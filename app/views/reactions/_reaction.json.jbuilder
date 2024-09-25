json.extract! reaction, :id, :status, :user_id, :reactionable_type, :reactionable_id, :created_at, :updated_at
json.url reaction_url(reaction, format: :json)
