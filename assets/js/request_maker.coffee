class window.RequestMaker
  constructor: ->
    @xmlhttp = new XMLHttpRequest
    @page = 1
    @bindRequestListener()

  bindRequestListener: ->
    @xmlhttp.onreadystatechange = =>
      @fillData() if @xmlhttp.readyState == XMLHttpRequest.DONE && @xmlhttp.status == 200

  fillData: ->
    @page += 1
    new ContentFiller(@response()).fill()

  response: ->
    JSON.parse @xmlhttp.response

  gather_data: ->
    @xmlhttp.open 'GET', @url(), true
    @xmlhttp.send()

  load_data: ->
    @gather_data()

  url: ->
    "https://api.dribbble.com/v1/shots?access_token=efa901b48f971a1d84713a305fbda01cde0d94362d33dc3b37de1aabc16a3401&page=#{@page}&per_page=20"
