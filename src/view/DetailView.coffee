define [
	'../app'
	'layoutmanager'
	'backbone'
	'timepicker'
	'moment'
],(app)->

	readablizeBytes = (bytes)->
      s = ['bytes', 'kB', 'MB', 'GB', 'TB', 'PB'];
      e = Math.floor(Math.log(bytes) / Math.log(1024));
      (bytes / Math.pow(1024, Math.floor(e))).toFixed(2) + " " + s[e]

	class DetailView extends Backbone.View
		manage:true
		template:"app/template/segment_detail"
		events:
			'click #delete':'onDeleteClick'
			'click #reset':'onResetClick'
			'click #save':'onSaveClick'

		serialize:->
			j = null
			if @model
				j = @model.toJSON()
				if j.contentModel
					j.contentModel = j.contentModel.toJSON()
					j.contentModel.size = readablizeBytes(j.contentModel.size)
					j.contentModel.duration = j.contentModel.duration/1000
			model:j

		onDeleteClick:(e)->
			if $(e.target).hasClass('disabled') then return
			if @model then @model.destroy()
			false

		onSaveClick:(e)->
			if $(e.target).hasClass('disabled') then return
			if @model then @model.save()
			false

		onResetClick:(e)->
			if $(e.target).hasClass('disabled') then return
			if @model then @model.revert()
			false

		initialize:->
			@collection.on 'segmentSelected',@setNewModel,@

		onReset:->
			@collection.reset(@collection.selectedSegment)

		setNewModel:(model)->
			if @model then @model.off 'change:startDate change:playDuration change:startOffset',@afterRender,@
			@model = null
			if model
				@model = model
				@model.on 'change:startDate change:playDuration change:startOffset',@afterRender,@
			@render()

		afterRender:->
			startDate     = "00:00:00"
			playDuration  = "00:00:00"
			startOffset   = "00:00"

			if @model
				startDate     = moment(@model.get('startDate')).format('HH:mm:ss')
				playDuration  = moment(@model.get('playDuration')).format('HH:mm:ss')
				startOffset   = moment(@model.get('startOffset')).format('mm:ss')

			@$el.find('#startDate').timepicker(
				minuteStep:1
				secondStep:1
				showSeconds:true
				showInputs:false
				disableFocus:false
				showMeridian:false
				# template:'modal'
			).timepicker('setTime',startDate)
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
			).timepicker('setTime', playDuration)
			.on('changeTime.timepicker',@onPlayDurationPick)
			.addClass('disabled')

			@$el.find('#startOffset').timepicker(
				minuteStep:1
				secondStep:1
				showInputs:false
				disableFocus:false
				showMeridian:false
				# template:'modal'
			).timepicker('setTime',startOffset)
			.on('changeTime.timepicker',@onPlayStartOffPick)
			.addClass('disabled')

			deleteBtn = @$el.find('#delete').addClass('disabled')
			saveBtn   = @$el.find('#save').addClass('disabled')
			resetBtn  = @$el.find('#reset').addClass('disabled')

			if @model
				deleteBtn.removeClass('disabled')
				if @model.hasBeenModifed()
					saveBtn.removeClass('disabled')
					resetBtn.removeClass('disabled')


		onStartTimePick:(e)=>
			eventTime = e.time
			if @model
				time = moment(@model.get('startDate'))
				.hour(eventTime.hours)
				.minute(eventTime.minutes)
				.second(eventTime.seconds)
				@model.set('startDate',time.valueOf())

		onPlayDurationPick:(e)=>
			eventTime = e.time
			if @model
				time = moment(@model.get('playDuration'))
				.hour(eventTime.hours)
				.minute(eventTime.minutes)
				.second(eventTime.seconds)
				@model.set('playDuration',time.valueOf())

		onPlayStartOffPick:(e)=>
			eventTime = e.time
			if @model
				time = moment(@model.get('startOffset'))
				.minute(eventTime.hours)
				.second(eventTime.minutes)
				@model.set('startOffset',time.valueOf())


