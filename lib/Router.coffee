define [
  "App"
  './collection/SegmentCollection'
  './collection/ContentCollection'
  './view/TimeLineView'
  './view/DetailView'
  './view/TableView'
  './view/AddSegmentView'
  './view/InfoPanelView'
  'moment'
  'layoutmanager'
],(app,SegmentCollection,ContentCollection,TimeLineView,DetailView,TableView,AddSegmentView,InfoPanelView)->


	readablizeBytes = (bytes)->
	  s = ['bytes', 'kB', 'MB', 'GB', 'TB', 'PB']
	  e = Math.floor(Math.log(bytes) / Math.log(1024))
	  (bytes / Math.pow(1024, Math.floor(e))).toFixed(2) + " " + s[e]


	Router = Backbone.Router.extend

		initialize:->		
			app.globals = {}
			app.globals.playerId = '517406256f81af0000000002'
			app.globals.server   = ''
			
			@segments = new SegmentCollection()
			@contents = new ContentCollection()

			app.useLayout('app/layout/index')
			.setViews({
				".timeline":new TimeLineView(collection:@segments)
				".segment_detail_view": new DetailView(collection:@segments)
				".segment_table_view" : new TableView(collection:@segments)
				".add_segment_view"   : new AddSegmentView(contents:@contents,segments:@segments)
				".info_panel"         : new InfoPanelView(collection:@segments)
			})

		routes:
			"": "index"
			"date/:date":"dateSelected"
			
		index:->
			@dateSelected()

		dateSelected:(date)->
			date = moment(date)
			if !date.isValid() then date = moment().startOf('day')
			app.globals.selectedDate = date

			@segments.fetch({
				data:{	
					fromDate:date.valueOf()
					toDate:moment(date).add('day',1).valueOf();
				}
			})
			
			@segments.on 'add',(model)->console.log "modal added"

			@navigate "date/"+date.format('YYYY-M-DD')
