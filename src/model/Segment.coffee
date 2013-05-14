define [
	'backbone'
	'moment'
],()->

	class Segment extends Backbone.Model
		idAttribute: "_id"


		initialize: ->
			Backbone.Model.prototype.initialize.apply(@, arguments)
			@mark_to_revert()
			@color = '#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6)

		defaults:
			playDuration:600000
			startOffset:0
			content:""
			transitions:[]
			selected:false

		save:(attrs, options)->
			self = @
			options || (options = {})
			success = options.success
			options.success = (resp) ->
				self.mark_to_revert()
				self.trigger("save:success", self)
				success(self, resp) if (success)
			@trigger("save", this)
			Backbone.Model.prototype.save.call(this, attrs, options)

		hasBeenModifed:()->
			if @isNew() then return true
			_.find @attributes,(value,key)=>
				if key == 'selected' then return false
				@_revertAttributes[key]!= value

		mark_to_revert:=>
			@_revertAttributes = _.clone @attributes

		revert:=>
			@_revertAttributes.selected = @attributes.selected;
			@set(@_revertAttributes, {silent : false}) if @_revertAttributes
