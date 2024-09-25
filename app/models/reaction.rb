class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :reactionable, polymorphic: true

  enum status: { unliked: 0, liked: 1, disliked: 2 }
end
