define ['../Utils','backbone'],(Utils)->
	
	RowView=Backbone.View.extend
		tagName:'tr'
		
		events:
			"destroy":"onDestroy"
			'click':'onClick'
		
		initialize:->
			@model.on("change:startDate change:playDuration",@render,@)
			@model.on("change:selected",@onSelected,@)
			@$el.attr("id",@model.get('id'))
		
		template:_.template("""
			<td>{{contentId}}</td>
			<td>{{startDate}}</td>
			<td>{{endDate}}</td>a
			<td>{{playDuration}}</td>
			<td>{{synced}}</td>
		""");

		onDestroy:->
			@off();
			@remove();

		onClick:(e)->
			@model.select();


		onSelected:(segment)->
			if(segment.get('selected'))
				@$el.addClass('selectedRow')
			else 
				@$el.removeClass('selectedRow')

		render:->
			tag=@$el
			tag.empty();

			contentId=@model.get('contentId')
			endDate=Utils.timeToStringFormat(@model.getEndDate()/1000)
			startDate=Utils.timeToStringFormat(@model.get("startDate")/1000)
			playDuration=Utils.timeToStringFormat(@model.get("playDuration")/1000)

			markup=@template({contentId,endDate,startDate,playDuration,synced:@model.isNew()})
			tag.append(markup)

			@onSelected(@model)
			@	

