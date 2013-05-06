define [
	'app'
	'backbone'
	'timepicker'
	'moment'
],(app)->

	class DetailView extends Backbone.View
		template:"app/template/segment_detail"
		
		events:{

		}

		initialize:->
			@collection.on 'segmentSelected',@onSegmentSelect,@ 

		onReset:->
			@collection.reset(@collection.selectedSegment)

		onSegmentSelect:(segment)->
			@model = segment
			@render()

		setNewModel:(model)->
			# @model.on 'change:startDate change:playDuration change:startOffset',@afterRender,@

		afterRender:->
			if !@model then return 

			@$el.find('#startDate').timepicker(
				minuteStep:1
				secondStep:1
				showSeconds:true
				showInputs:false
				disableFocus:false
				showMeridian:false
				# template:'modal'
			).timepicker('setTime', moment(@model.get('startDate')).format('HH:mm:ss'))
			.on('changeTime.timepicker',@onStartTimePick)
			.addClass('disabled')

			@$el.find('#playDuration').timepicker(
				minuteStep:1
				secondStep:1
				showSeconds:true
				showInputs:false
				disableFocus:false
				showMeridian:false
				# template:'modal'
			).timepicker('setTime', moment(@model.get('playDuration')).format('HH:mm:ss'))
			.on('changeTime.timepicker',@onPlayDurationPick)
			.addClass('disabled')

			@$el.find('#startOffset').timepicker(
				minuteStep:1
				secondStep:1
				showSeconds:true
				showInputs:false
				disableFocus:false
				showMeridian:false
				# template:'modal'
			).timepicker('setTime', moment(@model.get('startOffset')).format('HH:mm:ss'))
			.on('changeTime.timepicker',@onPlayStartOffPick)
			.addClass('disabled')

		onStartTimePick:(e)=>
			eventTime = e.time
			if @model 
				time = moment(@model.get('startDate'))
				.hour(eventTime.hours)
				.minute(eventTime.minutes)
				.second(eventTime.seconds)
				console.log e.time.minutes,time.minutes()

		onPlayDurationPick:(e)->
			eventTime = e.time
			if @model 
				time = moment(@model.get('playDuration'))
				.hour(eventTime.hours)
				.minute(eventTime.minutes)
				.second(eventTime.seconds)
				@model.set('playDuration',time.valueOf())

		onPlayStartOffPick:(e)->
			eventTime = e.time
			if @model 
				time = moment(@model.get('startOffset'))
				.hour(eventTime.hours)
				.minute(eventTime.minutes)
				.second(eventTime.seconds)
				@model.set('startOffset',time.valueOf())


