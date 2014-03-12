class TracksController < ApplicationController

  def show

    track = Track.find_by(track_id: params[:id])

    if ( track.nil? )
      base_track = "http://ocdn.shazamid.com/orbit/getsmoid/en/US/Play_Web/1/-/US/Web/-/-/50/track/" ;

      response = open(base_track + params[:id].to_s ).read
      parsed_response = JSON.parse(response)
      title =  parsed_response["title"]
      artist = parsed_response["description"]
      artist_id = parsed_response["artists"][0]["id"]
      picture = parsed_response["images"]["image400"]
      track = Track.new(
          title: title ,
          artist: artist ,
          artist_id: artist_id ,
          image: picture,
          track_id: params[:id]
       )

      track.save!

    end

    render json: track

  end

end
