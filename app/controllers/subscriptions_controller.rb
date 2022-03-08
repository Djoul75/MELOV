class SubscriptionsController < ApplicationController
  before_action :subscription_find, only: %i[show]

  def show
    @subscription = Subscription.find(params[:id])
  end

  def new
    @subscription = Subscription.new
  end

  # def create
  #   @subscription = Subscription.new
  #   authorize @subscription
  #   @subscription.following = current_user
  #   @subscription.follower = User.find(params[:id])
  #   @subscription.save
  # end

  # def destroy
  #   @subscription = Subscription.find_by(follower_id: params[:id], following_id: current_user.id)
  #   authorize @subscription
  #   @subscription.destroy
  # end

  def toggle
    skip_authorization
    @subscription = Subscription.find_by(follower_id: params[:user_id], following_id: current_user.id)

    if @subscription
      @count = @subscription.follower.followers.count - 1
      @subscription.destroy
      render json: { status: :destroyed, count: "#{@count} Subscribers" }
    else
      @subscription = Subscription.create(follower_id: User.find(params[:user_id]).id, following_id: current_user.id)
      render json: { status: :created, count:"#{ @subscription.follower.followers.count} Subscribers" }
    end
  end


  private

  def subscription_find
    @subscription = Subscription.find(params[:id])
  end
end
