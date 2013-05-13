define [
	"jquery"
	"underscore"
	"backbone"
	"handlebars"
	"layoutmanager"
],()->

	app =
		root: "/"

	JST = window.JST = window.JST || {};

	Backbone.Layout.configure({
		manage: true

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


