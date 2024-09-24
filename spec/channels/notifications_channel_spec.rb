require 'rails_helper'

RSpec.describe NotificationsChannel, type: :channel do
  let(:user) { create(:user) }

  before do
    stub_connection current_user: user
  end

  describe '#subscribed' do
    before { subscribe }

    it 'subscribes to a stream for the current user' do
      expect(subscription).to be_confirmed
      expect(subscription).to have_stream_for(user)
    end
  end

  context 'when subscribed' do
    before { subscribe }

    describe '#unsubscribed' do
      it 'stops all streams' do
        expect(subscription).to have_stream_for(user)

        unsubscribe
        expect(subscription).not_to have_streams
      end
    end
  end
end
