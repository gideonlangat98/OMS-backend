require 'net/smtp'

class ManagersController < ApplicationController
  # before_action :authenticate_manager, except: [:show, :update]
  before_action :deny_access, only: [:destroy, :create, :update]

  def index
    @manager = Manager.all
    render json: @manager, status: :ok
  end

  # signup request for staff
  def create
    pass = SecureRandom.alphanumeric(10).upcase
    manager_pars = manager_params
    manager_pars[:password] = pass

    manager = Manager.create!(manager_pars)

    email_body = "Hello #{manager.f_name},\n\nYou've been signed up to OMS!\n\nYour credentials:\n\nUsername: #{manager_params[:email]}\nPassword: #{pass}\n\nPlease login to the Office Management System using the following link:\nhttps://office-management-system.vercel.app"

    email_hash = {
      sender_email: 'omstestemail8@gmail.com',
      sender_password: 'nwhoqqdfalraychl',
      recipient_email: manager_params[:email],
      subject: "Account Created Successfully!",
      body: email_body
    }

    if manager
      send_pass(email_hash)
      render json: manager, status: :created
    else
      render json: { error: manager.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # request me
  def show
    render json: current_manager
  end

  def destroy
    manager = Manager.find_by(id: params[:id])
    if manager
      manager.destroy
      head :no_content
    else
      render json: { error: "Manager not found" }, status: :not_found
    end
  end

  private

  def set_manager
    manager = Manager.find(params[:id])
  end

  def manager_params
    params.require(:manager).permit(:f_name, :l_name, :managers_title, :email, :password, :password_confirmation)
  end

  def deny_access
    render_unauthorized unless authenticate_admin
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  # Method to send an email with staff's password
  def send_pass(email_hash)
    message = <<~MESSAGE
      From: <#{email_hash[:sender_email]}>
      To: <#{email_hash[:recipient_email]}>
      Subject: #{email_hash[:subject]}

      #{email_hash[:body]}
    MESSAGE


    Net::SMTP.start('smtp.gmail.com', 587, 'localhost', email_hash[:sender_email], email_hash[:sender_password], :login) do |smtp|
      smtp.send_message(message, email_hash[:sender_email], email_hash[:recipient_email])
    end
  end
end



