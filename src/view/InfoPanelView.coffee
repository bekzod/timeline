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
			seg = @getCurrentSegment()
			obj = {time:moment().format(" HH : mm : ss")}
			if seg
				endDate = seg.get('startDate')+seg.get('playDuration')
				obj.segmentId = seg.id
				obj.endsIn = moment(endDate - Date.now()).format(" HH : mm : ss");
				obj.endDate = moment(endDate).format(" HH : mm : ss")
				obj.startDate = moment(seg.get('startDate')).format(" HH : mm : ss")
			obj


		getCurrentSegment:()->
			now = Date.now()
			@collection.find (each)-> each.get('startDate') < now && each.get('endDate') > now


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



