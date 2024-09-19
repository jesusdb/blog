# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { described_class.new(user_attributes) }

  let(:user_attributes) { { email:, password:, password_confirmation: } }
  let(:email) { 'user@example.com' }
  let(:password) { 'password' }
  let(:password_confirmation) { 'password' }

  it 'has the admin field set to false as default' do
    expect(user.admin?).to be false
  end

  context 'when the user has all attributes set with valid values' do
    it { is_expected.to be_valid }
  end

  shared_examples 'a user with invalid email' do |email_value|
    let(:email) { email_value }

    it { is_expected.not_to be_valid }
  end

  context 'when the email has an incorrect format' do
    invalid_emails = %W[ aaa a@a user.com user@@example.com admin..user@example.com a_l#{'o'*55}ng_user@example.com ]

    invalid_emails.each do |invalid_email|
      it_behaves_like 'a user with invalid email', invalid_email
    end
  end

  context 'when the password does not match the password confirmation' do
    let(:password_confirmation) { 'foo' }

    it { is_expected.not_to be_valid }
  end
end
