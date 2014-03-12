class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :artist
      t.string :title
      t.string :image
      t.string :track_id
      t.string :artist_id

      t.timestamps
    end
  end
end
