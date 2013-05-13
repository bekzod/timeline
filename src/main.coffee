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
    	timepicker:
    		deps:['jquery','bootstrap']
    	bootstrap:
    		deps:['jquery']
    	backbonegrid:
    		deps:['backbone']
    	backbonemodal:
    		exports:'Backbone.BootstrapModal'
    		deps:['backbone','bootstrap']



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
		timepicker         : "../components/bootstrap-timepicker/js/bootstrap-timepicker"
		bootstrap 		   : "../components/bootstrap/bootstrap/js/bootstrap.min"
		backbonegrid       : "../components/backbone.datagrid/dist/backbone.datagrid"
		backbonemodal 	   : "../components/backbone.bootstrap-modal/src/backbone.bootstrap-modal"
		# queryparams 	   : "../components/backbone-query-parameters/backbone.queryparams.js"

require [
	'App'
	'Router'
	'view/TimeLineView'
	'view/DetailView'
	'collection/SegmentCollection'
],(app,Router,TimeLineView,DetailView,SegmentCollection)->

	app.globals = {}
	app.router  = new Router();

	Backbone.history.start({ root: app.root });
	
	$(document).on "click", "a:not([data-bypass])",(evt)->
		href = { prop: $(this).prop("href"), attr: $(this).attr("href") }
		root = location.protocol + "//" + location.host + app.root;

		if href.prop && href.prop.slice(0, root.length) == root
			evt.preventDefault()
			Backbone.history.navigate(href.attr, true)


