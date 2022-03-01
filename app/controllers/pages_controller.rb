require 'open-uri'
require 'json'
require 'rspotify'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def search
    query = 'Thriller'
    @song = RSpotify::Track.search(query).first.name
  end
end
