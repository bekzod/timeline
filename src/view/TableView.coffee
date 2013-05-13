define [
	'./TableItem'
	'layoutmanager'
],(TableItem)->

	class TableView extends Backbone.View
		manage:true
		template:'app/template/table_view'

		initialize:->
			@collection.on 'add',@onSegmentAdd,@
			@collection.on 'reset',@onCollectionReset,@

		onCollectionReset:->
			@render()

		onSegmentAdd:(seg)->
			tableItem = new TableItem(model:seg)
			@insertView "tbody",tableItem
			tableItem.render();

		afterRender:->
			@collection.models.forEach (seg)=>
				@onSegmentAdd seg




