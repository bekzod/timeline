define ['backbone'],()->
	DatePickerView=Backbone.View.extend
		tagName:'table'
		className:'timePicker'

		events:
			'click a.hourIncrement':'hourIncrement'
			'click a.hourDecrement':'hourDecrement'
			'click a.minuteIncrement':'minuteIncrement'
			'click a.minuteDecrement':'minuteDecrement'
			'click a.secondIncrement':'secondIncrement'
			'click a.secondDecrement':'secondDecrement'
			'change input[name=hour]':'onChangeInputHour'
			'change input[name=minute]':'onChangeInputMinute'
			'change input[name=second]':'onChangeInputSecond'

		initialize:->
			@hour=0
			@minute=0
			@second=0

		onChangeInputHour:(e)=>
			val=e.currentTarget.value
			@setHour(val,true)
			
		setHour:(val,dispatchEvent)->
			val=parseInt(val)
			if(val<0)
				val=23;
			if(val>23)
				val=0; 
			@hour=val;
			val=('0'+val) if val<10
			@$el.find('input[name=hour]').attr('value',val);
			time={@hour,@minute,@second}
			if(dispatchEvent is yes)
				@trigger('timechange',time)

		hourIncrement:->
			@setHour(@hour+1,true)

		hourDecrement:->
			@setHour(@hour-1,true)

		
		onChangeInputMinute:(e)=>
			val=e.currentTarget.value
			@setHour(val,true)
			
		setMinute:(val,dispatchEvent)->
			val=parseInt(val)
			if(val<0)
				@hourDecrement()
				val=59;
			if(val>59)
				val=0; 
			@minute=val;
			val=('0'+val) if val<10
			@$el.find('input[name=minute]').attr('value',val);
			time={@hour,@minute,@second}
			if(dispatchEvent is yes)
				@trigger('timechange',time)

		
		minuteIncrement:->
			@setMinute(@minute+1,true)

		minuteDecrement:->
			@setMinute(@minute-1,true);

		onChangeInputSecond:(e)=>
			val=e.currentTarget.value
			@setHour(val,true)
			
		setSecond:(val,dispatchEvent)->
			val=parseInt(val)
			if(val<0)
				@minuteDecrement();
				val=59;
			if(val>59)
				val=0; 
			@second=val;
			val=('0'+val) if val<10
			@$el.find('input[name=second]').attr('value',val);
			time={@hour,@minute,@second}
			if(dispatchEvent is yes)
				@trigger('timechange',time)

		secondIncrement:->
			@setSecond(@second+1,true)

		secondDecrement:->
			@setSecond(@second-1,true)

		template:->
			'''
				<table>
					<tbody>
						<tr>
							<th>Hours</th>
							<td></td>
							<th>Mins</th>
							<td></td>
							<th>Secs</th>
						</tr>
						<tr>
							<td>
								<a class='hourIncrement btn'><i class='icon-chevron-up'></i></a>
							</td>
							<td></td>
							<td>
								<a class='minuteIncrement btn' ><i class='icon-chevron-up'></i></a>
							</td>
							<td></td>
							<td>
								<a class='secondIncrement btn '><i class='icon-chevron-up'></i></a>
							</td>
						</tr>
						<tr'>
							<td><input style="width:25px;" type="text" name="hour" maxlength="2"/></td>
							<td>:</td>
							<td><input style="width:25px;" type="text" name="minute" maxlength="2"/></td>
							<td>:</td>
							<td><input style="width:25px;" type="text" name="second" maxlength="2"/></td>
						</tr>
						<tr>
							<td>
								<a class='hourDecrement btn '><i class='icon-chevron-down'></i></a>
							</td>
							<td></td>
							<td>
								<a class='minuteDecrement btn '><i class='icon-chevron-down'></i></a>
							</td>
							<td></td>
							<td>
								<a class='secondDecrement btn' ><i class='icon-chevron-down'></i></a>
							</td>
						</tr>
					</tbody>
				</table>
			'''

		render:->
			tag=@$el
			tag.empty();
			tag.html(@template());
			@setHour(0);
			@setMinute(0);
			@setSecond(0);
			@