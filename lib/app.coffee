define [
	"./collection/SegmentCollection"
	"./view/TimeLineView"
	"./view/TableView"
	"./view/SegmentDetailView"
	"./model/Segment"
	'jquery'
	]
	,(SegmentCollection,TimeLineView,TableView,SegmentDetailView,Segment)->
		template:"""
			<div class="container">	

				<legend>Video Management System</legend>	
				<div id="tablecontainer"  class='navbar-inner span4'></div>	
				
				<div id='segmentdetailcontainer' class="span5"></div>
				
				<div class="span12" style="margin-bottom: 10px"></div>

				<div class="row">
					<div class="span6 offset1">
						<a id='addSegment' class="btn"><i class="icon-plus"></i> Add Segmnet</a>
						<a class="btn" id='zoomout'><i class="icon-zoom-out"></i></a>
						<a class="btn" id="zoomin"><i class="icon-zoom-in"></i></a>
					</div>
				</div>

				<div class="span12" style="margin-bottom:10px"></div>
				
				<div class="row">
					<div class="span1" style="text-align: center; height:100%;">
						<a class="btn" id='left'><i class="icon-chevron-left"></i></a>
					</div>
					
					<div class="span10">
						<div id="timelineconatiner" class="timelineConatiner"></div>
					</div>
					
					<div class="span1" style="text-align: center; height:100%;">
						<a class="btn" id="right"><i class="icon-chevron-right"></i></a>
					</div>
				</div>

				<div class="span12" style="margin-bottom: 50px"></div>
			</div>	
			"""

		init:()->
			_.bindAll(@)
			@collection = new SegmentCollection()
			@timeline   = new TimeLineView({collection:@collection}).render()
			
			$template   = $(@template)

			$template.find('#segmentdetailcontainer').html(new SegmentDetailView().render().el)
			$template.find('#timelineconatiner').html(@timeline.el);
			$template.find('#tablecontainer').html(new TableView({collection:@collection}).render().el);
			

			$template.find('a#addSegment').on('click',@onAddSegment)

			$template.find('a#left').on('click',@onLeftBtnClick)
			$template.find('a#right').on('click',@onRightBtnClick)
			
			$template.find('a#zoomin').on('click',@onZoomIn)
			$template.find('a#zoomout').on('click',@onZoomOut)

			$('body').html($template);

		onAddSegment:(e)->
			@collection.add (new Segment(
				startDate     :Date.now()
				playDuration  :500*60*60
				totalDuration :1000*60*60))

		onZoomOut:(e)->
			@timeline.zoomOut()

		onZoomIn:(e)->
			@timeline.zoomIn()

		onLeftBtnClick:(e)->
			@timeline.$el.parent().animate(
				scrollLeft:'-=100'
				200)

		onRightBtnClick:(e)->
			@timeline.$el.parent().animate(
				scrollLeft:'+=100'
				200)
