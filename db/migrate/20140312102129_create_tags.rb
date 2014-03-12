class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.float :latitude
      t.float :longitude
      t.integer :track_id
      t.string :account_id
      t.string :system
      t.string :system_version
      t.string :device
      t.string :platform
      t.string :country

      t.timestamps
    end
  end
end
