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
			@model.on 'change save:success',@render,@
			@model.on 'destroy',@remove,@

		serialize:->
			id = @model.get('id');
			id = id && id.substr(id.length-2);
			startTime = moment(@model.get('startDate')).format('HH:mm:ss')
			isSaved = !@model.hasBeenModifed()
			{
				id
				startTime
				isSaved
				contentId:@model.get('content')
			}
			
		afterRender:->
			if @model.get('selected')
				@$el.addClass('success')
			else
				@$el.removeClass('success')





			

		
