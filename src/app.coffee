define [
	"jquery"
	"underscore"
	"backbone"
	"handlebars"
	"layoutmanager"
],()->

	app =
		root: "/"
		globals:
			playerId : '517406256f81af0000000002'
			server   : 'http://altermedia.nodejitsu.com'

	_.extend(app,{
		module: (additionalProps)->
			_.extend({ Views: {} }, additionalProps)

		useLayout:(name, options)->
			if @layout && @layout.options.template == name
				return @layout

			if @layout then @layout.remove()

			layout = new Backbone.Layout(
				_.extend(
						template: name
						className: "layout " + name
						id: "layout"
				,options)
			)

			$("#main").empty().append(layout.el)
			layout.render()
			@layout = layout
			layout
	}, Backbone.Events)


