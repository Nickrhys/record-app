class Record < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  belongs_to :artist
  has_many :tracks
  accepts_nested_attributes_for :tracks
end
