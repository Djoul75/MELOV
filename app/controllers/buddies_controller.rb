class BuddiesController < ApplicationController
  def new
    @buddy = Buddy.new
  end

  def create
    @buddy = Buddy.new(p)
  end
end
