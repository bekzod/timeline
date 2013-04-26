define [
	'app'
	'backbone'
	'timepicker'
],(app)->

	DetailView = Backbone.View.extend
		template:"app/template/segment_detail"
		
		events:{
			'click #save:not(.disabled)' :'onSave'
			'click #reset:not(.disabled)':'onReset'
			'change:startDate model':'onStartDateChange'
		}

		initialize:->
			@collection.on 'segment_select',@onSegmentSelect,@

		onStartDateChange:->
			console.log 'onStartDateChange'

		onSegmentSelect:(seg)->
			@model = seg;

		onSave:->
			console.log 'on Save'

		onReset:->
			console.log 'on Reset'
			@collection.reset(@collection.selectedSegment)

		afterRender:->
			@$el.find('#startDate').timepicker(
				minuteStep: 1
				secondStep:1
				showSeconds:true
				showInputs: false
				disableFocus: false
				showMeridian:false;
				# template:'modal'
			).timepicker('setTime', '12:12:12')
			.on('changeTime.timepicker',@onTimeChange)
			.addClass('disabled')

		onTimeChange:(e)->
			console.log e.time



