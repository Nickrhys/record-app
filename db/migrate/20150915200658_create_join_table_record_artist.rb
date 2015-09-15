class CreateJoinTableRecordArtist < ActiveRecord::Migration
  def change
    create_join_table :records, :artists do |t|
      t.index :record_id
      t.index :artist_id
    end
  end
end
