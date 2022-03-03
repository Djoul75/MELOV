require 'open-uri'
require 'json'
require 'rspotify'

class PagesController < ApplicationController

  def home
    return unless user_signed_in?

    following_ids = current_user.followings.ids+[current_user.id]
    @publications = policy_scope(Publication).where(user_id: following_ids).order(created_at: :desc)
    @publication = Publication.new
  end

  def search
    @tracks = RSpotify::Track.search(params[:query]) if params[:query].present?

    # render :json => @tracks
    # filepath = render :json => @search

    # serialized_artist = File.read(filepath)

    # @artist = JSON.parse(serialized_artist)
  end
end
