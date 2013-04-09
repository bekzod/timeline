define ['./SegmentView','../Utils'],(SegmentView,Utils)->
	

	MAX_ZOOM = 11520
	MIN_ZOOM = 1440

	INTIAL_AMOUNT = 1440
	ZOOM_AMOUNT = 60*9
	
	TimeLineView = Backbone.View.extend
		className:'timeline'
		
		events:
			"mousedown .segmentview":"onDown"
			"reset":'render'

		initialize:->
 			@width = INTIAL_AMOUNT
 			@secondsInPixel = @width/24/60/60
 			@collection.on 'add',$.proxy(@collectionAdd,@)

		onDown:(e)->
			@$container.children().css('z-index':100)
			$(e.currentTarget).css('z-index':200) 

		collectionAdd:(seg)->
			segView = new SegmentView {model:seg,parent:@,secondsInPixels:@secondsInPixel}
			@$container.append(segView.render().el);
		
		zoomIn:->
			newWidth = @width + ZOOM_AMOUNT
			if newWidth < MAX_ZOOM
				@width = newWidth 
				@relayout()

		zoomOut:->
			newWidth = @width - ZOOM_AMOUNT
			if newWidth > MIN_ZOOM
				@width = newWidth
				@relayout()

		relayout:->
			@secondsInPixel = @width/24/60/60
			@trigger('relayout',[@secondsInPixel]);
			newWidth = @width
			@$el.width(@width)
			@makeTimeLine()

		moveRedLine:->
			now    = new Date()
			time   = now.getHours()*60*60+now.getMinutes()*60+now.getSeconds();
			offset = @secondsInPixel*time
			@$redLine.width(offset) if @$redLine
			setTimeout @moveRedLine,100

		makeTimeLine:->
			@$overlay.empty()
			timecount = Math.floor(@width/120)
			while(timecount--)
				offset = timecount*120
				time = Utils.secondsToTime(offset/@secondsInPixel)
				formatedTime = time.h+':'+time.m+':'+time.s;
				
				tag = $("<div>#{formatedTime}</div>")
				tag.css( position:'absolute' )
				tag.offset( {top:20,left:offset-27} )
				
				@$overlay.append(tag);

		render:->
			tag = @$el;
			tag.empty();
			@$redLine   = $('<div class="timeline_redline">') 
			@$overlay   = $('<div class="timeline_overlay" >')
			@$container = $('<div class="timeline_container">')

			line = $('<div>')
			.css(
				float :"right"
				height:"100%"
				width :"2px"
				"background-color":'#ff0000'
			)

			@$redLine.append(line)

			@collection.each (seg) => @collectionAdd(seg)

			tag.append @$container 
			tag.append @$overlay 
			tag.append @$redLine 
			tag.width  @width

			@makeTimeLine()
			@moveRedLine()
			@