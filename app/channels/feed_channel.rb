class FeedChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    user = User.find(params[:id])
    #user = point en commun
    stream_for user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
