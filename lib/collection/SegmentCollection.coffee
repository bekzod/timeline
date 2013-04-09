define ['../model/Segment','backbone'],(Segment)->

	SegmentCollection=Backbone.Collection.extend
			url:'/api/segment/123456'
			model:Segment

			initialize:->
				@currentlySelected=null
				@on('change:startDate',@onStartDateChange)

			onSegmentSelectChange:(model)->
				if(@currentlySelected is not model)
					if(@currentlySelected)
						@currentlySelected.deselect();
					@currentlySelected=model;
					# @trigger('selected',model)

			onStartDateChange:->
				@sort();

			comparator:(model)->
				model.get('startDate')

			parse:(resp, xhr)->
				@header = resp.header;
				@stats = resp.stats;
				resp.result