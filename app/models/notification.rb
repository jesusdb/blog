# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: 'User'
  belongs_to :notifiable, polymorphic: true

  enum status: { unread: 0, read: 1 }
end
