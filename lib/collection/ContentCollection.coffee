define [
	'../model/Content'
	'backbone'
],(Content)->
	class ContentCollection extends Backbone.Collection
		url:->
			[@server
			'/player/content/'
			@playerId
			].join('')

		parse:(res)->
			res.result

		model:Content