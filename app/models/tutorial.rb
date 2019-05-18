class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :thumbnail
  validates_presence_of :playlist_id

  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def self.public_versions
    Tutorial.where(classroom: false)
  end

end
