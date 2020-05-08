class NotificationsController < ApplicationController

    def user_notifications
        puts "get notifications"
        puts params
        if params[:id] then
            notifications = Notification.where(user_id: params[:id])
            render json: notifications, include: [:question] # to get the question title
        else
            # error
        end
    end

    def destroy
        puts "destroy notification"
        puts params
        note = Notification.find(params[:id])

        # remove all notifications for this question/user pair
        if note then
            question_id = note.question_id
            user_id = note.user_id
    
            notifications = Notification.where(question_id: question_id, user_id: user_id)

            notifications.each do |n|
                n.destroy
            end
        end
    end
end