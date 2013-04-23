require.config 
	shim:
    	backbone:
    		exports : 'Backbone'
    		deps    : ['jquery','underscore']
    	underscore: 
    		exports : '_'
    	jqueryui:
    		deps:['jquery']
    	layoutmanager:
    		deps:['backbone']

	paths:
		moment             : "components/moment/moment"
		handlbars          : "components/handlebars/handlebars"
		backbone           : "components/backbone/backbone"
		underscore         : "components/underscore/underscore"
		jquery             : "components/jquery/jquery"
		socketio           : "components/socket.io-client/lib/socket.io-client"
		jqueryui           : "components/jquery-ui/ui/jquery-ui.custom"
		layoutmanager      : "components/layoutmanager/backbone.layoutmanager"


require ['./lib/app','lib/collection/SegmentCollection','moment','jquery','underscore','backbone']
,(app,SegmentCollection,moment)->
	_.templateSettings = interpolate : /\{\{(.+?)\}\}/g

	# app.init()

	collection = new SegmentCollection()
	collection.fetch(
			data: 
				fromDate: moment().startOf('day').unix()
				toDate: moment().endOf('day').unix()

			success:(err,res)->
				console.log collection.models[0]
		)
