class TagsController < ApplicationController

  require 'open-uri'

  def create

    puts post_params

    tag = Tag.new(
        latitude: post_params["latitude"],
        longitude: post_params["longitude"],
        track_id: post_params["track_id"],
        account_id: post_params["account_id"],
        system: post_params["system"],
        system_version: post_params["system_version"],
        device: post_params["device"],
        platform: post_params["platform"],
        country: post_params["country"]
      )
    tag.save!

    render json: tag

  end

  def show

    tag = Tag.find(params[:id])

    base_product = "http://ocdn.shazamid.com/orbit/getsmoid/en/US/Play_Web/1/-/US/Web/-/-/50/product/" ;
    base_track = "http://ocdn.shazamid.com/orbit/getsmoid/en/US/Play_Web/1/-/US/Web/-/-/50/track/" ;
    base_artist = "http://ocdn.shazamid.com/orbit/getsmoid/en/US/Play_Web/1/-/US/Web/-/-/50/artist/" ;

    response = open(base_track + tag.track_id.to_s ).read
    parsed_response = JSON.parse(response)
    title =  parsed_response["title"]
    artist = parsed_response["description"]
    latitude = tag.latitude
    longitude = tag.longitude
    artist_id = parsed_response["artists"][0]["id"]
    picture = parsed_response["images"]["image400"] ;

    render json: {
      title: title ,
      artist: artist ,
      longitude: longitude,
      latitude: latitude,
      artist_id: artist_id ,
      created_at: tag.created_at ,
      image: picture
    }
    #render json: tag

  end

  private
  def post_params
    params.permit( :track_id,
      :latitude,
      :longitude,
      :account_id,
      :system,
      :system_version,
      :device,
      :platform,
      :country
    )
  end
end
