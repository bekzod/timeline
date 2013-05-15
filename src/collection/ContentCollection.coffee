define [
	'../App'
	'../model/Content'
	'backbone'
],(app,Content)->
	class ContentCollection extends Backbone.Collection
		url:->
			[app.globals.server,
			'/player/content/',
			app.globals.playerId
			].join('')

		parse:(res)->
			res.result

		model:Content
