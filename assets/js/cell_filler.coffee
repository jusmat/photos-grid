class window.CellFiller
  constructor: (shot) ->
    @shot = shot

  divCreator: (className) ->
    div = document.createElement('div')
    div.className = className
    div

  nodeCreator: ->
    @divCreator('card')

  overlayCreator: ->
    @divCreator('overlay')

  titleCreator: ->
    title = @divCreator('title')
    title.appendChild document.createTextNode(@shot.title)

  authorCreator: ->
    author = @divCreator('author')
    author.appendChild document.createTextNode(@shot.user.name)

  imageCreator: ->
    image = document.createElement('img')
    image_url = if @retina() then @shot.images.hidpi else @shot.images.normal
    @preloadImage image_url, image
    image

  preloadImage: (image_url, original_image) ->
    original_image.src = 'loader.gif'
    image_preloader = new Image
    image_preloader.src = image_url
    if image_preloader.complete
      original_image.src = image_url
      image_preloader.onload = ->
    else
      image_preloader.onload = ->
        original_image.src = image_url
        image_preloader.onload = ->
        return
    return

  lineCreator: ->
    document.createElement('hr')

  buttonCreator: ->
    button = @divCreator('button')
    button.id = @shot.id
    button.appendChild document.createTextNode('Favorite')
    FavoritesManager.updateButton(button)
    button

  isHighDensity: ->
    window.matchMedia and (window.matchMedia('only screen and (min-resolution: 124dpi), only screen and (min-resolution: 1.3dppx), only screen and (min-resolution: 48.8dpcm)').matches or window.matchMedia('only screen and (-webkit-min-device-pixel-ratio: 1.3), only screen and (-o-min-device-pixel-ratio: 2.6/2), only screen and (min--moz-device-pixel-ratio: 1.3), only screen and (min-device-pixel-ratio: 1.3)').matches) or window.devicePixelRatio and window.devicePixelRatio > 1.3

  isRetina: ->
    (window.matchMedia and (window.matchMedia('only screen and (min-resolution: 192dpi), only screen and (min-resolution: 2dppx), only screen and (min-resolution: 75.6dpcm)').matches or window.matchMedia('only screen and (-webkit-min-device-pixel-ratio: 2), only screen and (-o-min-device-pixel-ratio: 2/1), only screen and (min--moz-device-pixel-ratio: 2), only screen and (min-device-pixel-ratio: 2)').matches) or window.devicePixelRatio and window.devicePixelRatio >= 2) and /(iPad|iPhone|iPod)/g.test(navigator.userAgent)

  retina: ->
    @isHighDensity() || @isRetina()

  fill: ->
    node = @nodeCreator()
    overlay = @overlayCreator()
    image = @imageCreator()

    node.appendChild image
    node.appendChild overlay

    title = @titleCreator()
    author = @authorCreator()

    line = @lineCreator()
    button = @buttonCreator()

    overlay.appendChild title
    overlay.appendChild line
    overlay.appendChild author
    overlay.appendChild button

    document.getElementById('container').appendChild node
