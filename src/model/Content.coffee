define [
  '../app'
	'backbone'
],(app)->

	class Content extends Backbone.Model
    urlRoot:->
      url = [app.globals.server
      '/player/content/'
      app.globals.playerId
      '/'
      @id
      ].join('')

      url


    parse:(res)->
      console.log res
      res
      # res.result

    idAttribute: "_id"
    defaults:
      size:0
      hash:''
      onwers:[]
      duration:-1
      type:''
      description:{}
