class window.ContentFiller
  constructor: (data) ->
    @data = data

  fill: ->
    @data.forEach (shot) ->
      new CellFiller(shot).fill()
