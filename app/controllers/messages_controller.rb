class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]

  def sent_messages
    if current_staff
      # If the current user is a staff member, retrieve messages sent by staff.
      @sent_messages = Message.where(sender_type: 'staff', staff_id: current_staff.id)
    elsif current_admin
      # If the current user is an admin, retrieve messages sent by admins.
      if params[:staff_id].present?
        # If a staff_id parameter is provided, filter by that staff member.
        @sent_messages = Message.where(sender_type: 'admin', admin_id: current_admin.id, staff_id: params[:staff_id])
      else
        # If no staff_id parameter is provided, retrieve all messages sent by the admin.
        @sent_messages = Message.where(sender_type: 'admin', admin_id: current_admin.id)
      end
    else
      # Handle the case when the user is not authenticated.
      render json: { error: 'Authentication required' }, status: :unauthorized
      return
    end
  
    render json: @sent_messages
  end  
  def received_messages
    if current_staff
      # If the current user is a staff member, retrieve messages received by them.
      @received_messages = Message.where(staff_id: current_staff.id, sender_type: 'admin')
    elsif current_admin
      # If the current user is an admin, retrieve messages received by them.
      staff_id = params[:staff_id]
      if staff_id.present?
        # If a staff_id parameter is provided, filter by that staff member.
        @received_messages = Message.where(admin_id: current_admin.id, sender_type: 'staff', staff_id: staff_id)
      else
        # If no staff_id parameter is provided, retrieve all messages received by the admin.
        @received_messages = Message.where(admin_id: current_admin.id, sender_type: 'staff')
      end
    end
  
    render json: @received_messages
  end  

  def send_to_admin
    # Retrieve the ID of the logged-in staff member from your authentication system.
    staff_id = current_staff.id
  
    # Remove the condition that restricts sending messages to only staff
    admin_member = Admin.find(params[:admin_id])
  
    message = Message.new(
      content: params[:content],
      channel: params[:channel],
      sender_type: 'staff',
      staff_id: staff_id,  # Set the staff_id to the ID of the logged-in staff
      admin_id: admin_member.id,
      read: true
    )
  
    if message.save
      ActionCable.server.broadcast("chat_#{message.channel}", { message: message.content })
      render json: message, status: :created
    else
      render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
    end
  end  

  def send_to_staff
    unless current_admin
      render json: { error: 'Only admins can send messages to staff' }, status: :unprocessable_entity
      return
    end
  
    staff_member = Staff.find(params[:staff_id])
  
    # Make sure to set the recipient's staff_id
    recipient_staff_id = staff_member.id
  
    # Use a unique channel identifier, for example, combining admin and recipient staff IDs
    channel = "admin_#{current_admin.id}_staff_#{recipient_staff_id}"
  
    message = Message.new(
      content: params[:content],
      channel: channel, # Set the unique channel identifier
      sender_type: 'admin',   # Set sender_type to 'admin'
      admin_id: current_admin.id,
      staff_id: recipient_staff_id,  # Set the staff_id based on the recipient staff
      read: false
    )
  
    if message.save
      ActionCable.server.broadcast("chat_#{message.channel}", { message: message.content })
      render json: message, status: :created
    else
      render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
    end
  end  

  def create
    message = Message.new(message_params)

    if set_sender(message)
      if message.save
        ActionCable.server.broadcast("chat_#{message.channel}", { message: message.content })
        render json: message, status: :created
      else
        render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Invalid sender type' }, status: :unprocessable_entity
    end
  end

  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @message.destroy
    head :no_content
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content, :channel, :staff_id, :admin_id)
  end

end
