class Record < ActiveRecord::Base
  belongs_to :artist
  has_many :tracks
  accepts_nested_attributes_for :tracks
end
