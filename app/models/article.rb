# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  acts_as_taggable_on :tags

  validates :title, presence: true
  validates :body, presence: true

  def self.search(query)
    if query.present?
      includes(:tags).where("title ILIKE ? OR tags.name ILIKE ?", "%#{query}%", "%#{query}%").references(:tags)
    else
      all
    end
  end
end
