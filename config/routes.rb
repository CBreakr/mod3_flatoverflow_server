Rails.application.routes.draw do
  resources :question_tags
  get "/tags/trending", to: "tags#trending"
  resources :tags
  resources :comment_upvotes
  resources :question_upvotes
  resources :comments
  resources :questions
  resources :users
  resources :follows

  get "/follows/filter/:current_user", to: "follows#filter"
 
  get "/questions/filter/:filter_type", to: "questions#filter", as: "filter"
  get "/questions/myfilter/:id", to: "questions#myfilter", as: "myfilter"
  patch "/comments/mark_answer/:id", to: "comments#mark_answer", as: "answer"

  get "/notifications/:id", to: "notifications#user_notifications", as: "notifications"
  delete "/notifications/:id", to: "notifications#destroy", as: "destroy_notification"
end
