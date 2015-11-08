class AddArtistIdToRecords < ActiveRecord::Migration
  def change
    add_column :records, :artist_id, :integer
  end
end
