define [
	'backbone'
	'moment'
],()->
	
	class Segment extends Backbone.Model
		idAttribute: "_id"

		defaults:
			startDate: Date.now()
			playDuration:600000
			startOffset:0
			content:""
			transitions:[]
			
			selected:false;
