class Record < ActiveRecord::Base
  belongs_to :artist
  has_many :tracks
  accepts
end
