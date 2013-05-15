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
		moment             : "http://altermedia.s3-eu-west-1.amazonaws.com/components/moment/moment"
		handlebars         : "http://altermedia.s3-eu-west-1.amazonaws.com/components/handlebars/handlebars"
		backbone           : "http://altermedia.s3-eu-west-1.amazonaws.com/components/backbone/backbone-min"
		underscore         : "http://altermedia.s3-eu-west-1.amazonaws.com/components/underscore/underscore-min"
		jquery             : "http://altermedia.s3-eu-west-1.amazonaws.com/components/jquery/jquery.min"
		socketio           : "http://altermedia.s3-eu-west-1.amazonaws.com/components/socket.io-client/lib/socket.io-client"
		jqueryui           : "http://altermedia.s3-eu-west-1.amazonaws.com/components/jquery-ui/ui/minified/jquery-ui.min"
		layoutmanager      : "http://altermedia.s3-eu-west-1.amazonaws.com/components/layoutmanager/backbone.layoutmanager"
		jqueryuitouchpunch : "http://altermedia.s3-eu-west-1.amazonaws.com/components/jquery-ui-touch-punch/jquery.ui.touch-punch.min"
		timepicker         : "http://altermedia.s3-eu-west-1.amazonaws.com/components/bootstrap-timepicker/js/bootstrap-timepicker.min"
		bootstrap 		     : "http://altermedia.s3-eu-west-1.amazonaws.com/components/bootstrap/docs/assets/js/bootstrap.min"
		backbonegrid       : "http://altermedia.s3-eu-west-1.amazonaws.com/components/backbone.datagrid/dist/backbone.datagrid.min"
		backbonemodal 	   : "http://altermedia.s3-eu-west-1.amazonaws.com/components/backbone.bootstrap-modal/src/backbone.bootstrap-modal"

require [
  './App'
  'layoutmanager'
],(app)->

  JST = window.JST = window.JST || {};

  Backbone.Layout.configure({
    fetch:(path)->
      path = path + ".html"
      done = null
      if !JST[path]
        done = @async()
        return $.ajax({ url: app.root + path }).then (contents)->
          JST[path] = Handlebars.compile(contents)
          JST[path].__compiled__ = true
          done(JST[path])

      if !JST[path].__compiled__
        JST[path] = Handlebars.template(JST[path])
        JST[path].__compiled__ = true

      JST[path]
  })

  $(document).on "click", "a:not([data-bypass])",(evt)->
    href = { prop: $(this).prop("href"), attr: $(this).attr("href") }
    root = location.protocol + "//" + location.host + app.root;

    if href.prop && href.prop.slice(0, root.length) == root
      evt.preventDefault()
      Backbone.history.navigate(href.attr, true)

  app.init()


