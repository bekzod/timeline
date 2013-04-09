define ['jquery'
		'../../jam/backbone/backbone.js'
		# '../collection/SegmentCollection'
		# './TimeLineView'
		# './TableView'
		# './view/SegmentDetailView'
		# 'jquery-ui'
		],($,Backbone,SegmentCollection,TimeLineView,TableView,SegmentDetailView)->
		console.log Backbone.View
		class AppView extends Backbone.View

			intialize:->
				console.log 'daw'

			template:->
				'''
					<legend>Video Management System</legend>	
					<div id="tablecontainer"  class='navbar-inner span5'></div>	
					
					<div id='segmentdetailcontainer' class="span5"></div>
					
					<div class="span12" style="margin-bottom: 50px"></div>

					<div class="row">
						<div class="span6">
							<a class="btn" id='left'>LEFT</a>
							<a class="btn" id="right">RIGHT</a>
							<a id='addSegment' class="btn">Add Segmnet</a>
							<a class="btn" id='zoomout'>zoom out</a>
							<a class="btn" id="zoomin">zoom in</a>
						</div>
					</div>
					<div class="span12" style="margin-bottom:50px"></div>
					<div id="timelineconatiner" class="timelineConatiner"></div>
					<div class="span12" style="margin-bottom: 50px"></div>
				'''
			render:->
				@$el.html(@template())
				@

		# var collection=new SegmentCollection()
		# collection.fetch()

		# var timeline=new TimeLineView({collection:collection}).render();
		# var table=new TableView({collection:collection}).render()
		# var detail=new SegmentDetailView({collection:collection}).render()

		# var timecontainer=$('#timelineconatiner')
		# var tablecontainer=$('#tablecontainer')
		# var detialcontainer=$('#segmentdetailcontainer')

		# tablecontainer.append(table.el);
		# timecontainer.append(timeline.el)
		# detialcontainer.append(detail.el)

		# function addSegment(){
		# 	var models=collection.models
		# 	var lastModel=models[models.length-1]
		# 	var timeToStart=lastModel?lastModel.getEndDate():new Date().getTime()+2000;

		# 	collection.add({id:Math.floor(Math.random()*100),startDate:timeToStart,playDuration:500000,totalDuration:1000000})
		# }

		# $('#addSegment').on('click',function(){
		# 	addSegment()
		# 	});

		# $('#left').on('click', function() {
		# 	var ten=timeline.width*.1
		# 	timecontainer.animate({scrollLeft:"-="+ten})
		# 	});

		# $('#right').on('click', function() {
		# 	var ten=timeline.width*.1
		# 	timecontainer.animate({scrollLeft:"+="+ten})
		# 	});	

		# $('#zoomin').on('click',function(){
		# 	var currentScroll=timecontainer.scrollLeft()/timeline.width;
		# 	timeline.zoomIn();
		# 	var newScroll=currentScroll*timeline.width
		# 	timecontainer.scrollLeft(newScroll)

		# 	})

		# $('#zoomout').on('click',function(){
		# 	var currentScroll=timecontainer.scrollLeft()/timeline.width;
		# 	timeline.zoomOut();
		# 	var newScroll=currentScroll*timeline.width
		# 	timecontainer.scrollLeft(newScroll)
		# 	})


		# $('#drag').resizable().draggable();

		# function cometoToTime(){
		# 	var secondsInDay;
		# 	var time=new Date()
		# 	secondsInDay=time.getHours()*60*60+time.getMinutes()*60+time.getSeconds();
		# 	var scrollAmount=secondsInDay/(24*60*60)*timecontainer.width()
		# 	timecontainer.scrollLeft(scrollAmount);
		# }

		# $('.timepicker-default').timepicker({
		# 	showSeconds:true
		# 	,secondStep:1
		# 	,minuteStep:1
		# 	,showMeridian:false
		# 	});

		# cometoToTime()
		# });