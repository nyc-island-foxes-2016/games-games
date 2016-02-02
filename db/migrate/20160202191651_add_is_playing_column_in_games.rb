class AddIsPlayingColumnInGames < ActiveRecord::Migration
  def change
    add_column :games, :is_playing, :boolean, default: true
  end
end
