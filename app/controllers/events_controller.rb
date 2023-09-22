class EventsController < ApplicationController
    # before_action :authenticate_admin

    def index
        @event = Event.all
        render json: @event, status: :ok
    end

    def show
        @events = set_event
        render json: @events, status: :ok
    end
  
   # Create a new event and send invitations
   def create
    event_pars = event_params
  
    event = Event.create!(event_pars)
  
    # document_links = [download_document_event_url(event, document: event.documents.file.filename)]
    document_links = [download_document_event_url(event)]
  
    # Construct the email body with download links
    email_body = <<~BODY
      Hello,
  
      You've been invited for our Weekly Check-Up meeting to be held on:
      Date: #{event.date}\n\n
      Time: #{event.time}\n\n
      Agenda: #{event.agenda}\n\n
      Host: #{event.host}\n\n
      Trainer: #{event.trainer}\n\n
      Documents: #{document_links.join("\n")}
  
      Meeting Link: #{event.meeting_link}
  
      Best regards,
      Brathrand Company CEO
    BODY
  
    # Get the selected staff emails from the frontend
    selected_staff_emails = params[:staff_emails].split(',')
  
    email_hash = {
      sender_email: 'omstestemail8@gmail.com',
      sender_password: 'nwhoqqdfalraychl',
      recipient_email: selected_staff_emails, # Use the list of selected staff emails
      subject: "BRATHRAND EMAIL INVITE!",
      body: email_body
    }
  
    if event
      send_pass(email_hash)
      render json: event, status: :created
    else
      render json: { error: event.errors.full_messages }, status: :unprocessable_entity
    end
  end
  

    def download_document
        event = Event.find(params[:id])
        file_path = event.documents.path 
        send_file file_path, disposition: 'attachment'
    end

    def update
      event = set_event
      event.update(event_params)
      render json: event, status: :created
    end

    def destroy
        event = Event.find_by(id: params[:id])
         if event
          event.destroy
           head :no_content
         else
           render json: { error: "event not found" }, status: :not_found
         end
    end
    
    private

    def set_event
        @events = Event.find(params[:id])
    end
  
    def event_params
      params.permit(
        :date,
        :time,
        :agenda,
        :host,
        :trainer,
        :documents,
        :email,
        :meeting_link,
        :staff_id,
        :client_id,
        :manager_id
      )
    end
  
    def authenticate_admin
      # Implement authentication logic for admins here
    end
    def send_pass(email_hash)
        message = <<~MESSAGE
          From: <#{email_hash[:sender_email]}>
          To: #{Array(email_hash[:recipient_email]).join(', ')}  # Join multiple recipients if there are any
          Subject: #{email_hash[:subject]}
      
          #{email_hash[:body]}
        MESSAGE
      
        smtp_settings = {
          address: 'smtp.gmail.com',
          port: 587,
          user_name: email_hash[:sender_email],
          password: email_hash[:sender_password],
          authentication: :login
        }
      
        begin
            Net::SMTP.start(smtp_settings[:address], smtp_settings[:port], 'localhost', smtp_settings[:user_name], smtp_settings[:password], smtp_settings[:authentication]) do |smtp|
              smtp.send_message(message, email_hash[:sender_email], email_hash[:recipient_email])
            end
          rescue Net::SMTPFatalError => e
            # Handle SMTP errors
            Rails.logger.error("SMTP error: #{e}")
            # You can add additional error handling here, such as logging or notifying administrators.
          rescue SocketError => e
            # Handle socket errors (e.g., name resolution failure)
            Rails.logger.error("Socket error: #{e}")
            # You can add additional error handling here.
          end
        end
           
  end
  