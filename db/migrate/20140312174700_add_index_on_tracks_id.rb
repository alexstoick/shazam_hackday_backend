class AddIndexOnTracksId < ActiveRecord::Migration
  def change
    add_index :tags, :track_id
  end
end
