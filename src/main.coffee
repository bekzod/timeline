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
		jqueryui           : "../components/jquery-ui/ui/minified/jquery-ui.min"
		layoutmanager      : "../components/layoutmanager/backbone.layoutmanager"
		jqueryuitouchpunch : "../components/jquery-ui-touch-punch/jquery.ui.touch-punch.min"
		timepicker         : "../components/bootstrap-timepicker/js/bootstrap-timepicker.min"
		bootstrap 		     : "../components/bootstrap/js/bootstrap.min"
		backbonegrid       : "../components/backbone.datagrid/dist/backbone.datagrid"
		backbonemodal 	   : "../components/backbone.bootstrap-modal/src/backbone.bootstrap-modal"


require [
  'App'
  'Router'
  'layoutmanager'
],(app,Router)->
  Backbone.Layout.configure({manage:false})

  app.globals = {}
  app.globals.playerId = '517406256f81af0000000002'
  app.globals.server   = 'http://altermedia.nodejitsu.com'

  app.router  = new Router();

  Backbone.history.start({ root: app.root });

  $(document).on "click", "a:not([data-bypass])",(evt)->
    href = { prop: $(this).prop("href"), attr: $(this).attr("href") }
    root = location.protocol + "//" + location.host + app.root;

    if href.prop && href.prop.slice(0, root.length) == root
      evt.preventDefault()
      Backbone.history.navigate(href.attr, true)




