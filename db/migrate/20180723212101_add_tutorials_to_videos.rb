# migration to add tutorial id to videos table
class AddTutorialsToVideos < ActiveRecord::Migration[5.2]
  def change
    add_reference :videos, :tutorial, index: true
  end
end
