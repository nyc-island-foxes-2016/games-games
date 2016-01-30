class Game < ActiveRecord::Base
  
  def correct?(attempting_player, proposed_path)
    target =  attempting_player  == player1 ? board2 : board1
    target.start_with? proposed_path
  end

end
