Rails.application.routes.draw do
    resources :articles
    patch 'articles' => 'articles#scraping', as: :root_path
    root "articles#scraping"
end
