define ['./SegmentView','../Utils'],(SegmentView,Utils)->
	

	MAX_ZOOM=11520
	MIN_ZOOM=1440

	INTIAL_AMOUNT=1440
	ZOOM_AMOUNT=60*9
	
	TimeLineView=Backbone.View.extend
		tagName:'div'
		className:'timeline'
		
		events:
			"mousedown .segmentview":"onDown"
			"reset":'render'

		initialize:(options) ->
			_.bindAll(@)
			@width=INTIAL_AMOUNT;
			@secondsInPixel=@width/24/60/60;

			setInterval($.proxy(@moveRedLine,@),100)
			@collection.on 'add',@collectionAdd

		onDown:(e)->
			$target=$(e.currentTarget)
			for element in @$container.children()
				$(element).css('z-index':100);
			$target.css('z-index':200);

		collectionAdd:(seg)->
			segView=new SegmentView {model:seg,parent:@,secondsInPixels:@secondsInPixel};
			@$container.append(segView.render().el);
		
		zoomIn:->
			if @width<MAX_ZOOM
				@width+=ZOOM_AMOUNT
				@relayout()

		zoomOut:->
			if @width>MIN_ZOOM
				@width-=ZOOM_AMOUNT;
				@relayout()

		relayout:->
			@secondsInPixel=@width/24/60/60
			@trigger('relayout',[@secondsInPixel]);
			newWidth=@width
			@$el.animate(
				width:newWidth
			,200);
			@makeTimeLine()

		moveRedLine:->
			now=new Date()
			time=now.getHours()*60*60+now.getMinutes()*60+now.getSeconds();
			offset=@secondsInPixel*time
			@$redLine.css({'width':offset})

		makeTimeLine:->
			@$overlay.empty()
			timecount=Math.floor(@width/120)
			while(timecount--)
				offset=timecount*120
				time=Utils.secondsToTime(offset/@secondsInPixel)
				formatedTime=time.h+':'+time.m+':'+time.s;
				
				tag=$("<div>#{formatedTime}</div>")
				tag.css(
					"position":'absolute'
					)
				tag.offset({top:20,left:offset-27})
				
				@$overlay.append(tag);

		render:->
			tag=@$el;
			tag.empty();
			@$container=$('<div class="timeline_container">');
			@$overlay=$('<div class="timeline_overlay" >')
			@$redLine=$('<div class="timeline_redline">') 

			line=$('<div>')
			line.css(
				float:"right"
				height:"100%"
				width:"2px"
				"background-color":'#ff0000'
			)
			@$redLine.append(line)

			@collection.each (seg)=>
				@collectionAdd(seg)

			tag.append @$container ;
			tag.append @$overlay ;
			tag.append @$redLine ;
			tag.width @width

			@makeTimeLine()
			@