define [
	'../app'
	'../model/Segment'
	'backbone'
],(app,Segment)->
	class SegmentCollection extends Backbone.Collection
		url:->
			[
				app.globals.server
				'/player/segment/'
				app.globals.playerId
			].join('')

		model:Segment

		initialize:->
			@on 'change:selected',@onSelectedChange,@
			@on 'remove',@onDestroy,@
			@on 'add',@onAdd,@

		onDestroy:(model)->
			if model == @currentSegment
				@onSelectedChange(null)

		onAdd:(model)->
			@onSelectedChange(model)

		onSelectedChange:(seg)->
			if seg && !seg.get('selected') then return
			if seg == @currentSegment then return
			if @currentSegment
				@currentSegment.set('selected',false);
				@currentSegment = null
			@currentSegment = seg
			@trigger 'segmentSelected',@currentSegment

		parse:(res)->
			res.result

		onSegmentSelect:(seg)->
			if @selectedSegment then @reset(@selectedSegment)
			@selectedSegment = seg
