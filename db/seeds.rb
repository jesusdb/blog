# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Rails.logger.debug 'Starting Rails seed.'

Rails.logger.debug 'Creating first user.'
password = 'password'
user = User.new(email: 'user@example.com', password:, password_confirmation: password)
user.save! unless user
user = User.find_by(email: 'user@example.com') if user

Rails.logger.debug 'Creating Articles with tags.'
art = Article.find_or_create_by!(title: Faker::Book.title, body: Faker::Books::Lovecraft.sentence, user_id: user.id)
art.tag_list.add('kitchen')
art.save!

art = Article.find_or_create_by!(title: Faker::Book.title, body: Faker::Books::Lovecraft.sentence, user_id: user.id)
art.tag_list.add('sports')
art.save!

art = Article.find_or_create_by!(title: Faker::Book.title, body: Faker::Books::Lovecraft.sentence, user_id: user.id)
art.tag_list.add('health')
art.save!

Rails.logger.debug 'Finished seeding!'
