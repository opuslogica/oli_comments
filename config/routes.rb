OliComments::Engine.routes.draw do
end

Rails.application.routes.draw do
#  get "auth/:provider/callback" => "web_login/sessions#omniauth"
  resources :comments
end