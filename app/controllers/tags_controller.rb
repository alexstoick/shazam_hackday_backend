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

  def get_track_id
    render json: { track_id: Tag.find(params[:id]).track_id }
  end

  def show_first_5000
    render json: Tag.where("id > ?" , (params[:id].to_i * 5000) ).limit(5000)
  end

  def show_first_100
    popularity = Hash.new(0)
    Tag.all.find_in_batches( batch_size: 500 ) do |tags|
      tags.each do |tag|
        popularity[tag.track_id] += 1
      end
    end
    popularity = popularity.sort_by { |track, appearances| appearances }.reverse!
    render json: { "popularity_array" => popularity , "hash" => Hash[popularity] }
  end

  def show

    tag = Tag.find(params[:id])

    base_track = "http://ocdn.shazamid.com/orbit/getsmoid/en/US/Play_Web/1/-/US/Web/-/-/50/track/" ;

    response = open(base_track + tag.track_id.to_s ).read
    parsed_response = JSON.parse(response)
    title =  parsed_response["title"]
    artist = parsed_response["description"]
    latitude = tag.latitude
    longitude = tag.longitude
    artist_id = parsed_response["artists"][0]["id"]
    picture = parsed_response["images"]["image400"]

    render json: {
      title: title ,
      artist: artist ,
      longitude: longitude,
      latitude: latitude,
      artist_id: artist_id ,
      created_at: tag.created_at ,
      track_id: tag.track_id,
      image: picture
    }

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
