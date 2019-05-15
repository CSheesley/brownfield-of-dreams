class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :position

  def self.set_missing_postions
    missing_positions = Video.where(position: nil)
    missing_positions.each do |video|
      tutorial = Tutorial.find(video.tutorial_id)
      correct = tutorial.videos.reject {|vid| vid.position == nil }
      positions = correct.count
      video.update(position: (positions + 1))
    end
  end
end
