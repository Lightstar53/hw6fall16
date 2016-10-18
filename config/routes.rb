Rails.application.routes.draw do
 

  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  post 'movies/search_tmdb'
  post 'movies/add_tmdb'
end
