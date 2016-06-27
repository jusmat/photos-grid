class window.FavoritesManager
  @favorites: ->
    favs = sessionStorage.getItem('favorites');
    if favs then favs.split(',') else []

  @toggleFavorite: (id) ->
    favorite_ids = @favorites()
    if favorite_ids.indexOf(id) > -1
      favorite_ids.splice(favorite_ids.indexOf(id), 1)
    else
      favorite_ids.push(id)

    sessionStorage.setItem('favorites', favorite_ids)

  @updateButton: (button) ->
    favorite_ids = @favorites()
    if favorite_ids.indexOf(button.id) > -1
      button.innerHTML = 'Unfavorite'
    else
      button.innerHTML = 'Favorite'
