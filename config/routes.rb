Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/add", to: "drink#create"
      get "/brand", to: "drink#search_by_brand"
      get "/category", to: "drink#search_by_category"
      get "/find", to: "drink#search_by_category_price_sorted_asc"
      put "/update", to: "drink#update"
      delete "/delete", to: "drink#destroy"
    end
  end
end
