class ArtistsController < ApplicationController
  require 'open-uri'
  def show
    base_artist = "http://ocdn.shazamid.com/orbit/getsmoid/en/US/Play_Web/1/-/US/Web/-/-/50/artist/" ;
    response = open( base_artist + params[:id] ).read
    render json: response
  end

end
