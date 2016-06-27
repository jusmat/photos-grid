class window.Loader
  constructor: ->
    @request_maker = new RequestMaker
    @favorites_manager = FavoritesManager

  load: ->
    @doRequest()
    @bindScrollListener()
    @bindFavoriteAction()

  scrollOffset: ->
    document.body.scrollTop + window.innerHeight

  pageHeight: ->
    Math.max(
      document.body.scrollHeight,
      document.body.offsetHeight,
      document.body.clientHeight
    )

  bindScrollListener: ->
    document.addEventListener 'scroll', (event) =>
      @doRequest() if @pageHeight() <= @scrollOffset()

  bindFavoriteAction: ->
    document.addEventListener 'click', (event) =>
      @favorites_manager.toggleFavorite(event.target.id)
      @favorites_manager.updateButton(event.target)

  doRequest: ->
    @request_maker.load_data()
