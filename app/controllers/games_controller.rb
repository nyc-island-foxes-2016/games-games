class GamesController < ApplicationController
  def create
    g = Game.new(player1: params[:player], board1: params[:board])
    g.save!
    render json: { gameId: g.id, player: g.player1, result: 'OK', status: 201 }
  end

  def playing
    g = Game.find(params[:id])
    render json: { result: g.is_playing, status: 200 }
  end

  def accept
    g = Game.find(params[:id])
    g.player2 = params[:player]
    g.board2 = params[:board]
    g.save!
    render json: { gameId: g.id, player: g.player2, result: 'OK', status: 200 }
  end

  def attempt
    g = Game.find(params[:id])
    current_player = params[:player]
    if g.correct?(params[:player], params[:board])
      render json: { result: 'Yes', status: 200 }
    else
      render json: { result: 'No', status: 300 }, status: 300
    end
  end

  def waiting
    games = Game.where(player2: nil).pluck(:id)
    render json: games
  end

  def joined
    g = Game.find(params[:id])
    if !g.player2.nil?
      render json: { result: 'Yes', status: 200 }
    else
      render json: { result: 'No', status: 200 }
    end
  end

  def gameover
    g = Game.find(params[:id])
    g.update_attributes(is_playing: false)
    render json: { gameId: g.id, status: 200 }
  end

  def destroy
    g = Game.find(params[:id])
    if g.destroy!
      render json: { result: 'Yes', status: 200 }
    end
  end

end
