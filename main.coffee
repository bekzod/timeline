require.config 
	shim:
    	backbone:
    		exports : 'Backbone'
    		deps    : ['jquery','underscore']
    	underscore: 
    		exports : '_'
    	jqueryui:
    		deps:['jquery']

	paths:
		moment             : "components/moment/moment"
		backbone           : "components/backbone/backbone"
		underscore         : "components/underscore/underscore"
		jquery             : "components/jquery/jquery"
		socketio           : "components/socket.io-client/lib/socket.io-client"
		jqueryui           : "components/jquery-ui/ui/jquery-ui.custom"


require ['./lib/app','underscore','backbone'],(app)->
	_.templateSettings = interpolate : /\{\{(.+?)\}\}/g
	app.init()