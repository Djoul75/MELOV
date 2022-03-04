class SubscriptionsController < ApplicationController
  before_action :subscription_find, only: %i[show destroy]

  def show
    @subscription = Subscription.find(params[:id])
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new
    authorize @subscription
    @subscription.following = current_user
    @subscription.follower = User.find(params[:id])
    @subscription.save!
  end

  def destroy
    @subscription.destroy
    authorize @subscription
  end


  private

  def subscription_find
    @subscription = Subscription.find(params[:id])
  end
end
