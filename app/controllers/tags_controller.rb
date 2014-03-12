class TagsController < ApplicationController
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
