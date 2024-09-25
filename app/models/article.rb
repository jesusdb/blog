# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :reactions, as: :reactionable, dependent: :destroy

  acts_as_taggable_on :tags

  validates :title, presence: true
  validates :body, presence: true

  scope :unliked, ->() { includes(:reactions).where("status = 0").references(:reactionable) }
  scope :liked, ->() { includes(:reactions).where("status = 1").references(:reactionable) }
  scope :disliked, ->() { includes(:reactions).where("status = 2").references(:reactionable) }

  delegate :unliked, to: :reactions
  delegate :liked, to: :reactions
  delegate :disliked, to: :reactions

  def self.search(query)
    if query.present?
      includes(:tags).where("title ILIKE ? OR tags.name ILIKE ?", "%#{query}%", "%#{query}%").references(:tags)
    else
      all
    end
  end

  def liked_by?(user_id:)
    liked.where(user_id:)
  end
end
