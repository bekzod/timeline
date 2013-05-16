define [
	'../app'
	'layoutmanager'
	'backbone'
	'moment'
],(app)->

	class InfoPanelView extends Backbone.View
		manage:true
		template:"app/template/info_panel"

		initialize:->
			@startTimer();

		serialize:->
			{
				time:moment().format(" HH : mm : ss")
				segment:@getCurrentSegment()
			}

		getCurrentSegment:()->
			now = Date.now()
			seg = @collection.find (each)-> each.get('startDate') < now && each.get('endDate') > now
			if seg then seg.get('id') else 'none'

		startTimer:->
			if @started then return
			@started = true
			@onTick()

		stopTimer:->
			started = false
			clearTimeout(@timerid)

		onTick:=>
			if @started
				clearTimeout(@timerid)
				@timerid = setTimeout(@onTick,1000)
			@render()



