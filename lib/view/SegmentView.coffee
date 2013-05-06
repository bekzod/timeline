define [
	'App'
	'backbone'
	'layoutmanager'
	'jqueryui'
	'jqueryuitouchpunch'
],(app)->
	
	class SegmentView extends Backbone.Layout
		
		template:'app/template/segment_timeline'
		className:'segment_timeline'
		
		events:{
			'change:startDate model':'onStartDateChange'			
		}

		initialize:->
			@model.on 'reset',@onChange,@

		onChange:->
			console.log 'onChane' + @model.get('id')

		onReset:->
			@render()

		serialize:()->
			color = 'blue'
			id = @model.get('id')
			if id 
				color = '#'+id.split(0,6);
			{color}

		getOffset:()->
			startTime = new Date @model.get 'startDate'
			startTimeInSecond = startTime.getHours()*60*60*1000
			startTimeInSecond += startTime.getMinutes()*60*1000
			startTimeInSecond += startTime.getSeconds()*1000
			startTimeInSecond += startTime.getMilliseconds()
			startTimeInSecond/(24*60*60*1000) * app.globals.TIMELINE_WIDTH

		getWidth:()->
			duration = @model.get 'playDuration'
			duration/(24*60*60*1000) * app.globals.TIMELINE_WIDTH


		onDrag:(e,ui)->
			oldStartDate = new Date(@model.get('startDate'))
			newStartDate = new Date(ui.position.left/app.globals.TIMELINE_WIDTH*24*60*60*1000)
			oldStartDate.setHours(newStartDate.getHours())
			oldStartDate.setMinutes(newStartDate.getMinutes())
			oldStartDate.setSeconds(newStartDate.getSeconds())
			oldStartDate.setMilliseconds(newStartDate.getMilliseconds())

			@model.set('startDate',oldStartDate.getTime())


		onStartDateChange:->

		onDragStop:(e,ui)->

		afterRender:()=>
			@$el.draggable(
				containment:'parent'
				drag:_.bind(@onDrag,@)
				stop:@onDragStop
			)

			@$el.css({width:@getWidth(),left:@getOffset()})


