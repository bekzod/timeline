define ['../model/Segment','backbone'],(Segment)->

	SegmentCollection = Backbone.Collection.extend
			url:'http://127.0.0.1:8080/player/segment/517406256f81af0000000002'
			model:Segment

			initialize:->
				@on 'segment_select',@onSegmentSelect,@


			onSegmentSelect:(seg)->
				if @selectedSegment then @reset(@selectedSegment)
				@selectedSegment = seg


			parse:(res)->
				res.result