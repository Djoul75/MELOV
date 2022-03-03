require 'open-uri'
require 'json'
require 'rspotify'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def search
    @tracks = RSpotify::Track.search(params[:query]) if params[:query].present?

    # render :json => @tracks
    # filepath = render :json => @search

    # serialized_artist = File.read(filepath)

    # @artist = JSON.parse(serialized_artist)
  end
end
