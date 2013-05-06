define [
  "App"
  './collection/SegmentCollection'
  './collection/ContentCollection'
  './view/TimeLineView'
  './view/DetailView'
  './view/TableView'
  './view/AddSegmentView'
  'moment'
  'layoutmanager'
],(app,SegmentCollection,ContentCollection,TimeLineView,DetailView,TableView,AddSegmentView)->


	readablizeBytes = (bytes)->
	  s = ['bytes', 'kB', 'MB', 'GB', 'TB', 'PB']
	  e = Math.floor(Math.log(bytes) / Math.log(1024))
	  (bytes / Math.pow(1024, Math.floor(e))).toFixed(2) + " " + s[e]


	Router = Backbone.Router.extend

		initialize:->		
			app.globals = {}
			
			@segments = new SegmentCollection()
			@contents = new ContentCollection()

			@contents.playerId = '517406256f81af0000000002'
			@segments.playerId = '517406256f81af0000000002'
			@contents.server   = 'http://altermedia.nodejitsu.com'
			@segments.server   = 'http://altermedia.nodejitsu.com'

			app.useLayout('app/layout/index')
			.setViews({
				".timeline":new TimeLineView(collection:@segments)
				".segment_detail_view": new DetailView(collection:@segments)
				".segment_table_view" : new TableView(collection:@segments)
				".add_segment_view"   : new AddSegmentView(contents:@contents,segments:@segments)
			})

		routes:
			"": "index"
			"date/:date":"dateSelected"
			"date/:date/segment/:segment":"segmentSelected"
			
		index:->
			@dateSelected()

		dateSelected:(date)->
			date = moment(date)
			if !date.isValid() then date = moment().startOf('day')

			@segments.fromDate = date.valueOf()
			@segments.toDate   = moment(date).add('day',1).valueOf();
			@segments.fetch()
			
			@segments.on 'add',(model)->console.log "modal added"

			@navigate "date/"+date.format('YYYY-M-DD')


		segmentSelected:(date,segment)->
			if segment.length != 24 || @segments.fromDate != date || !@segments.length
				return @dateSelected(date)

			app.trigger 'segment:selected',segment










