define [
	'App'
	'backbone'
	'layoutmanager'
	'jqueryui'
	'jqueryuitouchpunch'
],(app)->
	
	SegmentView = Backbone.Layout.extend
		template:'app/template/segment_timeline'
		className:'segment_timeline'

		serialize:()->
			@model.toJSON()

		getOffset:()->
			startTime = new Date @model.get 'startDate'
			startTimeInSecond = startTime.getHours()*60*60*1000
			+ startTime.getMinutes()*60*1000
			+ startTime.getSeconds()*1000
			+ startTime.getMilliseconds()

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

		onDragStop:(e,ui)->


		afterRender:()->
			@$el.draggable(
				containment:'parent'
				drag:_.bind(@onDrag,@)
				stop:@onDragStop
			)

			@$el.css({width:@getWidth(),left:@getOffset()})


