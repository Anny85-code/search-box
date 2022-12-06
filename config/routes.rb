Rails.application.routes.draw do
  resources :articles
  
  root "articles#index"
  get "search", to: "articles#search"

   scope :api do
    post 'query/suggestions' => 'query#suggestions'
    post 'query' => 'query#search'
    get 'query' => 'query#all_searches'
    delete 'query' => 'query#reset_queries'
    delete 'query/all' => 'query#destroy_queries'
  end
end
