# app/mailers/event_mailer.rb
class EventMailer < ApplicationMailer
    def invite_staff(event, staff_email)
      @event = event
      mail(to: staff_email, subject: "Invitation to Event")
    end
end
  