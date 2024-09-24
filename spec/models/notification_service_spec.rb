# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationService, type: :model do
  subject(:notification_service) { described_class.new(notification:) }

  let(:notification) { create(:notification, :for_article) }

  describe '#send_notification' do
    before do
      allow(NotificationsChannel).to receive(:broadcast_to).with(notification.recipient, notification.attributes)
      notification_service.send_notification
    end

    it { expect(NotificationsChannel).to have_received(:broadcast_to).with(notification.recipient, notification.attributes) }
  end
end
