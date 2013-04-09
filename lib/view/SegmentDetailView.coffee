define ['./DatePickerView','../Utils'],(DatePickerView,Utils)->
	
	SegmentDetailView=Backbone.View.extend
		tagName:'div'
		className:'form-horizontal navbar-inner'
		events:
			"destroy":"onDestroy"
			"click .btn[type=delete]":'onDelete'
			"click .btn[type=save]":'onSave'

		initialize:->

			@startDatePicker=new DatePickerView(); 
			@startDatePicker.on 'timechange',@onStartTimeSet

			@durationDatePicker=new DatePickerView(); 
			@durationDatePicker.on 'timechange',@onDurationSet

		
		onDelete:->
			@model.destroy()

		onSave:->
			@model.save({},{success:(model,res)->
					id=res.result[0]
					model.isNew()
					model.set('id',id);
					console.log model.isNew();
				});

		onStartTimeSet:(data)->
			@model.off('change:startDate',@onStartDateChange)

			time=new Date(@model.get('startDate'))
			time.setHours(data.hour);
			time.setMinutes(data.minute);
			time.setSeconds(data.second);

			@model.set('startDate',time.getTime())
			
			@model.on('change:startDate',@onStartDateChange)


		onDurationSet:(data)=>
			@model.off('change:playDuration',@onPlayDurationChange)

			duration=(data.hour*60*60+data.minute*60+data.second)*1000
			totalDuration=@model.get('totalDuration')
			
			if duration>totalDuration
				duration=totalDuration
				time=Utils.secondsToTime(totalDuration/1000)
				@durationDatePicker.setHour(time.h);
				@durationDatePicker.setMinute(time.m);
				@durationDatePicker.setSecond(time.s);

			@model.set('playDuration',duration)
			@model.on('change:playDuration',@onPlayDurationChange)

		onStartDateChange:(model)=>
			time=model.getFormatedStartDate()

			@startDatePicker.setHour(time.h);
			@startDatePicker.setMinute(time.m);
			@startDatePicker.setSecond(time.s);

		onPlayDurationChange:(model)=>
			time=model.getFormatedPlayDuration()

			@durationDatePicker.setHour(time.h);
			@durationDatePicker.setMinute(time.m);
			@durationDatePicker.setSecond(time.s);
		
		template:_.template(
			'''
				<legend>Segment</legend>

				<div class="control-group">
					<label class="control-label"><h5>Start Time</h3></label>
					<div class="controls">
						<div id="startdate"></div>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label"><h5>Play Duration</h5></label>
					<div class="controls">
						<div id="playduration"></div>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">Total Duration</label>
					<label class="control-label" id='totalDuration'>00:00:00</label>
				</div>

				<div class="control-group">
					<div class="controls">
						<button type="save" class="btn">Save</button>
						<button type="delete" class="btn btn-danger">Delete</button>
					</div>
				</div>
			''')

		onDestroy:->
			@off();
			@remove();


		render:->
			tag=@$el
			tag.append(@template())
			@startDatePicker.setElement(tag.find('#startdate'))
			@durationDatePicker.setElement(tag.find('#playduration'))

			@startDatePicker.render()
			@durationDatePicker.render()

			if @model
				playduration=Utils.timeToStringFormat(@model.get('totalDuration')/1000)
				tag.find('#totalDuration').text(playduration)

				startime=@model.getFormatedStartDate()
				@startDatePicker.setHour(startime.h);
				@startDatePicker.setMinute(startime.m);
				@startDatePicker.setSecond(startime.s);

				duration=@model.getFormatedPlayDuration()
				@durationDatePicker.setHour(duration.h);
				@durationDatePicker.setMinute(duration.m);
				@durationDatePicker.setSecond(duration.s);
			@	

