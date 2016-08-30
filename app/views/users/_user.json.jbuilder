json.extract! user, :id, :firstname, :lastname, :login, :email, :external_id, :site_id, :manager_id, :created_at, :updated_at
json.url user_url(user, format: :json)
