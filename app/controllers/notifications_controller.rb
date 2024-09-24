class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: %i[ update destroy ]

  def update
    @notification.update(notification_params)
  end

  def destroy
    @notification.destroy!

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.json { head :no_content }
    end
  end

  def destroy_all
    current_user.notifications.destroy_all

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.json { head :no_content }
    end
  end

  private

    def notification_params
      params.require(:notification).permit(:status)
    end

    def set_notification
      @notification = Notification.find(params[:id])
    end
end
