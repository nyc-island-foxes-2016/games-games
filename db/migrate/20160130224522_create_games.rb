class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player1_id
      t.integer :player2_id
      t.string :board1
      t.string :board2

      t.timestamps null: false
    end
  end
end
