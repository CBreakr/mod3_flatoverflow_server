class NotificationChannel < ApplicationCable::Channel
    def subscribed
        puts "subscribed to notification"
        stream_from "NotificationChannel"
    end
    
    def unsubscribed
        puts "unsubscribed from notificaton"
        # Any cleanup needed when channel is unsubscribed
    end
end