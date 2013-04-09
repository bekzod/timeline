require.config 
	shim:
    	backbone:
    		deps    : ['jquery','underscore']
    		exports : 'Backbone'
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

require ['./lib/app','underscore'],(app)->
	_.templateSettings = interpolate : /\{\{(.+?)\}\}/g
	app.init()