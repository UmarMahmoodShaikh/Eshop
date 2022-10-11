module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  end
end
