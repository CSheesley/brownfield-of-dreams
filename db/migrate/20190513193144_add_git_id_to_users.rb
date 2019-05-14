class AddGitIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :git_id, :integer, default: nil
  end
end
