define ['../Utils','backbone'],(Utils)->
	
	Segment=Backbone.Model.extend
		url:'/api/segment/123456'
		
		defaults:
			startDate:0
			playDuration:0
			totalDuration:0
			appId:123456
			showAnimDuration:0
			hideAnimDuration:0
			hideAnimStartDate:0
			showAnimId:0
			hideAnimId:0
			startOffset:0
			contentId:0
			contentTypeId:0
			status:0
			
			selected:false
		
		initialize:->

		select:()->
			@set('selected',true);
			@collection.onSegmentSelectChange(@);

		deselect:->
			@set('selected',false);

		getEndDate:->
			@get('startDate')+@get('playDuration');

		getFormatedStartDate:->
			Utils.secondsToTime(@get('startDate')/1000)

		getFormatedPlayDuration:->			
			Utils.secondsToTime(@get('playDuration')/1000)

		validate:(attr)->
			if attr.playDuration
				if attr.playDuration>this.totalDuration
					attr.playDuration=this.totalDuration;
			false;