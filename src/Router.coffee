define [
  './app'
  './collection/SegmentCollection'
  './collection/ContentCollection'
  './view/TimeLineView'
  './view/DetailView'
  './view/TableView'
  './view/AddSegmentView'
  './view/InfoPanelView'
  './model/Content'
  'moment'
  'layoutmanager'
],(app,SegmentCollection,ContentCollection,TimeLineView,DetailView,TableView,AddSegmentView,InfoPanelView,Content)->


  readablizeBytes = (bytes)->
    s = ['bytes', 'kB', 'MB', 'GB', 'TB', 'PB']
    e = Math.floor(Math.log(bytes) / Math.log(1024))
    (bytes / Math.pow(1024, Math.floor(e))).toFixed(2) + " " + s[e]

  Router = Backbone.Router.extend

    initialize:(opts)->
      console.log app
      @segments = new SegmentCollection()
      @contents = new ContentCollection()

    routes:
      "": "index"
      "date/:date":"dateSelected"

    index:->
      app.useLayout('app/layout/index')
      .setViews({
        ".timeline"           : new TimeLineView(collection:@segments)
        ".segment_detail_view": new DetailView(collection:@segments)
        ".segment_table_view" : new TableView(collection:@segments)
        ".add_segment_view"   : new AddSegmentView(contents:@contents,segments:@segments)
        ".info_panel"         : new InfoPanelView(collection:@segments)
      })
      @dateSelected()
      cont = new Content(id:'b8fabdbb3ba2f617b6254223')
      cont.fetch().success(->console.log "success",cont.get('duration'))

    dateSelected:(date)->
      if !app.layout then return @index()

      date = moment(date)
      if !date.isValid() || date.isBefore(moment().startOf('day')) then date = moment().startOf('day')
      app.globals.selectedDate = date

      @segments.fetch(
        data:
          fromDate:date.valueOf()
          toDate:moment(date).add('day',1).valueOf();
      )
      @navigate "date/"+date.format('YYYY-M-DD')
