define [
	'App'
  	'backbonegrid'
	'backbonemodal'
],(app)->
	
	class AddSegmentView extends Backbone.View
		
		# template:'app/template/segment_timeline'
		el:false
		events:{
			click:'onClick'
		}

		onClick:(e)->
			e.preventDefault();
			e.stopImmediatePropagation();
			
			@modal = new Backbone.BootstrapModal(
				title      : "Select Media To Play"
				content    : @contentGrid
				animate    : true
				focusOk    : true
				okCloses   : true
				allowCancel: false
				okText:"cancel"
			)
			@modal.open()

		onModelSelect:(contentModel)->
			@modal.close()

			if app.globals.selectedDate.valueOf() > Date.now()
				startDate = app.globals.selectedDate.valueOf()
			else 
				startDate = Date.now()+1000*60*10

			@segments.add({
				startDate
				content:contentModel.id
				contentModel:contentModel
				selected:true
			})


		initialize:(opts)->
			self = @

			@segments = opts.segments
			@contents = opts.contents

			@contentGrid = new Backbone.Datagrid({
				collection:@contents
				# paginated:true
				# perPage:6
				columns:[
					{
						property:'_id'
						title:'id'
					}
					{
						property:'name'
						view: (file)->file.description.name
					}
					,'duration'
					,'type'
					{
						view: {
							type: Backbone.Datagrid.ActionCell
							label: 'Select'
							actionClassName: 'btn btn-primary'
							action:(model)->
								self.onModelSelect(model)
								false
						}
					}
				]
			})

			
		
		afterRender:->
			$('<a></a>',{class:"btn btn-primary",text:'Add Segment'}).appendTo(@$el)


