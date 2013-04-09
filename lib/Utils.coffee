define ['underscore'],(_)->	
	
	_.templateSettings = interpolate : /\{\{(.+?)\}\}/g
	secondsToTime=(secs)->
		hours = Math.floor(secs / (60 * 60))%24;
		divisor_for_minutes = secs % (60 * 60);
		minutes = Math.floor(divisor_for_minutes / 60)

		divisor_for_seconds = divisor_for_minutes%60;
		seconds = Math.ceil(divisor_for_seconds);	    
	
		{
	        "h": appendZero(hours)
	        "m": appendZero(minutes)
	        "s": appendZero(seconds)
	    }
	
	timeToStringFormat=(secs)->
    	time=secondsToTime secs
    	time.h+':'+time.m+':'+time.s

	generateColor=->
		rand=->(Math.floor(Math.random() * 256));
		color="rgb(#{ rand() },#{ rand() },#{ rand() })"
		color

	appendZero=(num)->
		if num<10 
			num='0'+num
		num

	{secondsToTime,generateColor,appendZero,timeToStringFormat}