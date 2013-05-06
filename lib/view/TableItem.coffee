define [
	'layoutmanager'
	'moment'
],()->
	
	class TableItem  extends Backbone.Layout
		template:'app/template/table_item'
		el:false
		events:{
			click:'onClick'
		}

		onClick:(e)->
			e.preventDefault();
			e.stopImmediatePropagation();
			@model.set('selected',true);

		initialize:->
			@model.on 'change',@onSelectChange,@

		serialize:->
			id = @model.get('id');
			id = id && id.substr(id.length-5);
			startTime = moment(@model.get('startDate')).format('HH:mm:ss')
			isSaved = !@model.isNew()

			{
				id
				startTime
				isSaved
				contentId:@model.get('content')
			}

		onSelectChange:->
			if @model.get('selected')
				@$el.addClass('success')
			else
				@$el.removeClass('success')
			
		afterRender:->
			@onSelectChange()





			

		
