class AddAvatarToRecords < ActiveRecord::Migration
  def change
    add_column :records, :avatar, :string
  end
end
