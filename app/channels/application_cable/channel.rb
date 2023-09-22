module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def subscribed
      stream_from "chat_#{params[:channel]}"
    end
  
    def receive(data)
      message = JSON.parse(data)
      Message.create(content: message['message'], channel: params[:channel])
    end
  
    def unsubscribed
      # Any cleanup needed when the channel is unsubscribed
    end
  end
end
