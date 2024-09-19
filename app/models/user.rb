# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :password
  validates :email, format: { with: /\A(?!.*\.\.)[a-z\d_.\-+]{1,50}@[a-z\d\-]{1,50}\.[a-z]{1,30}\z/i }

  has_many :comments, dependent: :destroy
end
