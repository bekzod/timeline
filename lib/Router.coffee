define [
  "App"
],(app)->

	Router = Backbone.Router.extend
		routes:
			"": "index"
			
		index: ()->

