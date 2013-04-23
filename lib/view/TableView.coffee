define ['./RowView','backbone'],(RowView)->

	TableView=Backbone.View.extend
		tagName:'table'
		className:'tableview table'
		
		initialize:->
			_.bindAll(@)
			@collection.on 'add',@onAddOne
			@collection.on 'reset',@render

		template:->
			'''
			<thead>
				<th>Content Id</th>
				<th>Start Date</th>
				<th>End Date</th>
				<th>Play Duration</th>
				<th>Synced</th>
			</thead>
			<tbody></tbody>
			'''

		onAddOne:(model)->
			@addOne(model)

		addOne:(model)->
			row = new RowView( model:model ).render()
			@$body.append(row.el)

		addCollection:(collection)->
			collection.each (model)=>@addOne model

		render:->
			tag=@$el
			tag.empty();
			tag.html(@template())
			@$body=tag.find('tbody')
			tag.append()
			@addCollection(@collection)
			@