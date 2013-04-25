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
    	handlebars:
    		exports:'Handlebars'
    	jqueryuitouchpunch:
    		deps:['jquery','jqueryui']

	paths:
		moment             : "../components/moment/moment"
		handlebars         : "../components/handlebars/handlebars"
		backbone           : "../components/backbone/backbone"
		underscore         : "../components/underscore/underscore"
		jquery             : "../components/jquery/jquery"
		socketio           : "../components/socket.io-client/lib/socket.io-client"
		jqueryui           : "../components/jquery-ui/ui/jquery-ui.custom"
		layoutmanager      : "../components/layoutmanager/backbone.layoutmanager"
		jqueryuitouchpunch : "../components/jquery-ui-touch-punch/jquery.ui.touch-punch"


require [
	'App'
	'Router'
	'view/TimeLineView'
	'collection/SegmentCollection'
],(app,Router,TimeLineView,SegmentCollection)->

	app.router  = new Router();
	app.globals = {}

	Backbone.history.start({ pushState: true, root: app.root });
	
	$(document).on "click", "a:not([data-bypass])",(evt)->
		href = { prop: $(this).prop("href"), attr: $(this).attr("href") }
		root = location.protocol + "//" + location.host + app.root;

		if href.prop && href.prop.slice(0, root.length) == root
			evt.preventDefault()
			Backbone.history.navigate(href.attr, true)

	segmentCollection = new SegmentCollection();

	app.useLayout('app/layout/index')
	.setView(".timeline",new TimeLineView(
		collection:segmentCollection
	))

	segmentCollection.fetch({add:true}).success ()->
		console.log segmentCollection.length





	



