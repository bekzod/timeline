define [
	'../app'
  'backbonegrid'
	'backbonemodal'
],(app)->

	class AddSegmentView extends Backbone.View

		el:false
		manage:true
		events:{
			click:'onClick'
		}

		onClick:(e)->
			@segments.fetch(
					success:=>
						console.log 'success'
						@contentGrid.refresh()
			)

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
			false

		onModelSelect:(contentModel)->
			@modal.close()
			if app.globals.selectedDate.valueOf() > Date.now()
				startDate = app.globals.selectedDate.valueOf()
			else
				startDate = Date.now()+1000*60*10

			@segments.add({
				startDate
				content:contentModel.id
				playDuration:contentModel.get('duration')
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
						view:
							type: Backbone.Datagrid.ActionCell
							label: 'Select'
							actionClassName: 'btn btn-primary'
							action:(model)=>
								@onModelSelect(model)
								false
					}
				]
			})



		afterRender:->
			$('<a></a>',{class:"btn btn-primary",text:'Add Segment'}).appendTo(@$el)


