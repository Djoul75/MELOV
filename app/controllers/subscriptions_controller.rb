class SubscriptionsController < ApplicationController

  def show
    @subscription = Subscription.find(params[:id])
  end

  def new
    @subscription = Subscription.new
  end

  def create

  end

end
