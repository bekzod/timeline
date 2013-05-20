define [
	'../app'
	'./SegmentView'
	'moment'
],(app,SegmentView)->

	MAX_ZOOM = 29380
	MIN_ZOOM = 1440

	INTIAL_AMOUNT = 5540
	ZOOM_AMOUNT   = 1060

	class TimeLineView extends Backbone.Layout
		template:'app/template/timeline'

		events:{
			'click #left'         : 'onLeft'
			'click #right'        : 'onRight'
			'click #zoomin'       : 'onZoomIn'
			'click #zoomout'      : 'onZoomOut'
			'click #showtimeline' : 'onShowTimeLine'
		}

		initialize:(opts)->
			@width = INTIAL_AMOUNT
			app.globals.TIMELINE_WIDTH = @width
			@collection.on 'add',@onSegmentAdd,@
			@collection.on 'reset',@onCollectionReset,@

		onCollectionReset:->
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
			if app.globals.selectedDate && app.globals.selectedDate.valueOf() < d.valueOf()
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
			newScrollValue = cont.scrollLeft() - @width*.05
			cont.clearQueue().animate(scrollLeft:newScrollValue)

		onRight:->
			cont = @$el.find('.timeline_container')
			newScrollValue = cont.scrollLeft() + @width*.05
			cont.clearQueue().animate(scrollLeft:newScrollValue)

		setNewWidth:(newWidth)=>
			if newWidth < MIN_ZOOM || newWidth > MAX_ZOOM then return
			ratio  = @$el.find('.timeline_background').position().left/@width

			oldcont = @$el.find('.timeline_container')
			loc     = oldcont.offset()
			scroll  = oldcont.scrollLeft()
			cloned  = oldcont.clone()
			.css(position:'absolute',width:@$el.width(),"z-index":100)
			.offset(loc).appendTo(@$el.parent())
			.scrollLeft(scroll)

			@width = newWidth
			app.globals.TIMELINE_WIDTH = newWidth

			@render()
			cloned.fadeOut(500,'easeOutBack',->$(@).remove())
			@$el.find('.timeline_container').scrollLeft(-@width*ratio)

		onShowTimeLine:->
			timeWidth = @$el.find('.timebox').width() - 100
			@$el.find('.timeline_container').clearQueue().animate(scrollLeft:timeWidth)


		onSegmentAdd:(model)->
			seg = new SegmentView( model:model)
			@insertView '.timeline_segment_container',seg
			seg.render();
