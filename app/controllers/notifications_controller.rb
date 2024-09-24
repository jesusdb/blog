class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: %i[ update destroy ]

  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_back(fallback_location: root_path, notice: 'Notification was successfully updated.') }
        format.json { head :no_content }
      else
        format.html { redirect_back(fallback_location: root_path, notice: 'Notification was not updated.') }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
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
