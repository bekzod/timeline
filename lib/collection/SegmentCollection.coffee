define [
	'../model/Segment'
	'backbone'
],(Segment)->
	class SegmentCollection extends Backbone.Collection
		url:->
			url = [
					@server
					'/player/segment/'
					@playerId
					'?fromDate='
					@fromDate
					'&toDate='
					@toDate
			].join('')
		
		model:Segment

		initialize:->
			@on 'change:selected',@onSelectedChange,@
			@on 'add',@onAdd,@

		onAdd:(model)->
			if model.get('selected')
				@onSelectedChange(model);				

		onSelectedChange:(seg)->
			if !seg.get('selected')||seg == @currentSegment then return
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
