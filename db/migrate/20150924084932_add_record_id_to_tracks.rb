class AddRecordIdToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :record_id, :integer

  end
end
