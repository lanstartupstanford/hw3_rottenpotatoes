Rottenpotatoes::Application.routes.draw do
  resources :movies
  # add to routes.rb, just before or just after 'resources :movies' :
     
  # Route that posts 'Search TMDb' form
  post '/movies/search_tmdb'

  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
