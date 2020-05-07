class NotificationsController < ApplicationController
    def destroy
        note = Notification.find(params[:id])
        if note then
            note.destroy
        end
    end
end