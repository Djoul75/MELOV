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
    @subscription.follower = current_user
    @subscription.following = User.find(params[:id])
    @subscription.save!
  end

  def destroy
    @subscription.destroy
  end


  private

  def subscription_find
    @subscription = Subscription.find(params[:id])
  end
end
