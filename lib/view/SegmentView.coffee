define ['../Utils','moment','backbone','jqueryui'],(Utils,moment)->
	
	SegmentView=Backbone.View.extend
		
		className :'segmentview'
		template  :_.template('''

		''')

		events:
			drag      : 'onDrag'
			resize    : 'onResize'
			mousedown : 'onMouseDown'
		
		initialize:(options)->
			@secondsInPixels = options.secondsInPixels				

			parent = options.parent 

			parent.on 'relayout',@relayout,@
			@model.on 'change:selected',@onSelectedChange,@
			@model.on 'change:startDate change:playDuration',@onDatesChanges
		
		onMouseDown:->
			@model.select();

		onSelectedChange:(model,value)->
			if(value)
				@select()
			else
				@deselect()
		
		onDatesChanges:=>
			if not @model.get('selected')
				@relayout(@secondsInPixels);

			startTime = new Date(@model.get('startDate'));
			endTime   = new Date(@model.get('playDuration')+startTime)

			time = Utils.secondsToTime @model.startDate

			h = Utils.appendZero(startTime.getHours())
			m = Utils.appendZero(startTime.getMinutes())
			s = Utils.appendZero(startTime.getSeconds())
			@$startDatePanel.text(" "+h+":"+m+":"+s);

			h = Utils.appendZero(endTime.getHours())
			m = Utils.appendZero(endTime.getMinutes())
			s = Utils.appendZero(endTime.getSeconds())
			@$endDatePanel.text(" "+h+":"+m+":"+s)
			
		
		relayout:(@secondsInPixels)=>
			width=@model.get('playDuration')/1000*@secondsInPixels
			maxWidth=@model.get('totalDuration')/1000*@secondsInPixels
			startDate=new Date @model.get('startDate')
			startOfset=startDate.getHours()*@secondsInPixels*60*60+startDate.getMinutes()*@secondsInPixels*60+startDate.getSeconds()*@secondsInPixels
			
			tag=@$el;
			tag.resizable('option','maxWidth',maxWidth);
			tag.animate(
					width:width
					left:startOfset
					,200
				)			

		select:->
			@$startDatePanel.show 200
			@$endDatePanel.show 200 
			@$el.addClass('selectedSegment')
		
		
		deselect:->
			@$startDatePanel.hide 200 ;
			@$endDatePanel.hide 200 ;
			@$el.removeClass 'selectedSegment'

			
		onDrag:->
			time=moment(@$el.position().left/@secondsInPixels)
			
			newDate=moment(@model.get('startDate'))
			newDate.hours(time.hours());
			newDate.minutes(time.minutes());
			newDate.seconds(time.seconds());
			newDate.milliseconds(time.milliseconds());
			# @model.set('startDate',newDate.valueOf());

		onResize:(e)->
			e.stopImmediatePropagation();

			@model.off('change:startDate change:playDuration',@onDatesChanges)
			@model.set 'playDuration',@$el.width()/@secondsInPixels*1000;
			@model.on('change:startDate change:playDuration',@onDatesChanges)
			@onDrag()
		
		render:->
			tag=@$el
			width=@model.get('playDuration')/1000*@secondsInPixels
			maxWidth=@model.get('totalDuration')/1000*@secondsInPixels
			startDate=new Date(@model.get('startDate'))
			startOfset=(startDate.getHours()*60*60+startDate.getMinutes()*60+startDate.getSeconds())*@secondsInPixels

			color=Utils.generateColor()	
			dragableOptions=
				axis: 'x'
				containment: 'parent'
				scroll:false
			
			resizableOptions=
				handles: 'e, w'
				maxWidth:maxWidth

			tag.draggable(dragableOptions)
			tag.resizable(resizableOptions)
			tag.attr('style','')
			tag.width(width)
			tag.offset({left:startOfset})

			startline=$ '<div></div>'
			startline.css
				'background-color':color
				width:2
				height:"50%"
				float:"left"
				position: "relative";
				"margin-left":-1

			endline=$ '<div></div>'
			endline.css
				'background-color':color
				width:2
				height:'50%'
				float:"right"
				"margin-right":1
			

			startDatePanel=$ '<p>'
			startDatePanel.css(
				"position":'absolute'
				"color":"#ffffff"
				"background-color":color
				"float":"right"
				"margin-left":-55
				"hidden":true
			)

			endDatePanel=$ '<p>'
			endDatePanel.css(
				"position":'absolute'
				"color":"#ffffff"
				"background-color":color
				"hidden":true
			)

			box=$ '<div></div>'
			box.css({
				width:"100%"
				height:'50%'
				"background-color":color
				"margin-left":-1
				position: "absolute"
				bottom: 0
				})

			tag.append(startline);
			tag.append(endline);
			
			startline.append(startDatePanel)
			endline.append(endDatePanel)
			
			tag.append(box);

			@$startDatePanel=startDatePanel;
			@$endDatePanel=endDatePanel;
			@



