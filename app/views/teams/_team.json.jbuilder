json.extract! team, :id, :user_id, :name, :external_id, :created_at, :updated_at
json.url team_url(team, format: :json)