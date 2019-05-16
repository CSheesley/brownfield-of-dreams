namespace :db do
  desc "Set Missing Video Positions"
  task positions: :environment do
    Video.set_missing_positions
  end
end
