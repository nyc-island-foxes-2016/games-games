class GamesController < ApplicationController
  def create
    byebug
    g = Game.new(player1: params[:player], board1: params[:board])
    g.save!
    render json: { id:g.id, result: 'OK', status: 201 }
  end

  def accept
    g = Game.find(params[:id])
    g.player2 = params[:player]
    g.board2 = params[:board]
    g.save!
    render json: { result: 'OK', status: 200 }
  end

  def attempt
    g = Game.find(params[:id])
    current_player = params[:player]
    if g.correct?(params[:player], params[:board])
      render json: { result: 'Yes', status: 200 }
    else
      render json: { result: 'No', status: 404 }, status: 404
    end
  end

  def waiting
    games = Game.where(player2: nil).pluck(:player1, :created_at)
    render json: games
  end
end
