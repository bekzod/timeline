define [
	'app'
	'./SegmentView'
	'moment'
],(app,SegmentView)->

	MAX_ZOOM = 11520
	MIN_ZOOM = 1440

	INTIAL_AMOUNT = 1440
	ZOOM_AMOUNT   = 240

	class TimeLineView extends Backbone.Layout
		template:'app/template/timeline'

		events:{
			'click #left'    : 'onLeft'
			'click #right'   : 'onRight'
			'click #zoomin'  : 'onZoomIn'
			'click #zoomout' : 'onZoomOut'
		}

		initialize:(opts)->
			@width = INTIAL_AMOUNT
			app.globals.TIMELINE_WIDTH = @width
			@collection.on 'add',@onSegmentAdd,@
			@collection.on 'reset',@onCollectionReset,@

		onCollectionReset:->
			console.log "reset"
			@render()

		serialize:->
			times = []
			timecount      = Math.floor @width/120
			secondsInPixel = @width/(24*60*60)

			while timecount--
				offset = timecount*120
				time   = moment().startOf('day').seconds(offset/secondsInPixel).format("HH:mm:ss")
				times.unshift { time }

			times:times
			width:@width

		afterRender:->
			@collection.models.forEach (seg)=>
				@onSegmentAdd seg
			@moveTimeBox()

		moveTimeBox:->
			d = new Date()
			if app.globals.selectedDate.valueOf() < d.valueOf()
				boxWidth = @width * ((d.getHours()*60*60 + d.getMinutes()*60+d.getSeconds())/(24*60*60))
				@$el.find('.timebox').width boxWidth
				clearTimeout(@timerId)
				@timerId = setTimeout(_.bind(@moveTimeBox,@),500)
			else
				@$el.find('.timebox').width 0

		onZoomOut:->
			newWidth = @width - ZOOM_AMOUNT
			@setNewWidth(newWidth)

		onZoomIn:->
			newWidth = @width + ZOOM_AMOUNT
			@setNewWidth(newWidth)

		onLeft:->
			cont = @$el.find('.timeline_container')
			newScrollValue = cont.scrollLeft()-80
			cont.clearQueue().animate(scrollLeft:newScrollValue)

		onRight:->
			cont = @$el.find('.timeline_container')
			newScrollValue = cont.scrollLeft()+80
			cont.clearQueue().animate(scrollLeft:newScrollValue)

		setNewWidth:(newWidth)->
			if newWidth < MIN_ZOOM || newWidth > MAX_ZOOM then return
			ratio = @$el.find('.timeline_background').position().left/@width
			@width = newWidth
			app.globals.TIMELINE_WIDTH = @width
			@render()
			@$el.find('.timeline_container').scrollLeft(-@width*ratio)

		onSegmentAdd:(model)->
			seg = new SegmentView( model:model)
			@insertView '.timeline_segment_container',seg
			seg.render();
