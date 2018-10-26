class EventMailer < ApplicationMailer
    default from: 'eventMailer <admin@eventMailer.com>'
   
    def send_event_email(event, user)
        @event = event
        @user = user
        mail(to: user.email, subject: event.title)
    end
     
    def send_update_event_email(event, user)
        @event = event
        @user = user
        mail(to: user.email, subject: 'Update: ' + event.title)
    end

end
