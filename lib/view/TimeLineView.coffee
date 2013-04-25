define [
	'./SegmentView'
	'moment'
	'App'
],(SegmentView,moment,app)->

	MAX_ZOOM = 11520
	MIN_ZOOM = 1440

	INTIAL_AMOUNT = 1440
	ZOOM_AMOUNT   = 200

	TimeLineView = Backbone.View.extend
		template:'app/template/timeline'
		className:'timelineview'

		events:{
			'click #left'    : 'onLeft'
			'click #right'   : 'onRight'
			'click #zoomin'  : 'onZoomIn'
			'click #zoomout' : 'onZoomOut'
		}

		initialize:(opts)->
			@width = INTIAL_AMOUNT
			app.globals.TIMELINE_WIDTH = @width

			@collection.bind('add',@onSegmentAdd,@)

		serialize:()->
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

		onZoomOut:()-> 
			newWidth = @width - ZOOM_AMOUNT
			@setNewWidth(newWidth)

		onZoomIn:()->
			newWidth = @width + ZOOM_AMOUNT
			@setNewWidth(newWidth)

		onLeft:()->
			cont = @$el.find('.timeline_container')
			newScrollValue = cont.scrollLeft()-80
			cont.clearQueue().animate(scrollLeft:newScrollValue)

		onRight:()->
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

			seg = new SegmentView( 
				model:model
				template:'app/template/segment_timeline'
			)

			@insertView('.timeline_segment_container',seg)
			seg.render();
