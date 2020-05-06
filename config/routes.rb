Rails.application.routes.draw do
  resources :question_tags
  resources :tags
  resources :comment_upvotes
  resources :question_upvotes
  resources :comments
  resources :questions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users

  get "/questions/filter/:filter_type", to: "questions#filter", as: "filter"
  get "/questions/myfilter/:id", to: "questions#myfilter", as: "myfilter"

  patch "/comments/mark_answer/:id", to: "comments#mark_answer", as: "answer"
end
