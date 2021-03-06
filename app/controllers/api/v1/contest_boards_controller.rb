class Api::V1::ContestBoardsController < ApplicationController
  def index
    #/contest_boards 
    contest_boards = ContestBoard.all
    render json: contest_boards, status: 200
  end

  def show
    #/contest_board/:id
    contest_board = ContestBoard.find_by(id: params[:id])
    if contest_board
      render json: contest_board.to_json(include: [:contest_props]), status: 200
    else
      render json: {message: "The requested resource was not found"}, status: 204
    end
  end

  def current
    #/current
    contest_board = ContestBoard.all.last
    contest_props = ContestProp.filter_by_contest_board(contest_board)
    render json: contest_props, status: 200
  end
  
  def create
    #/contest_boards
    name = DateTime.now.beginning_of_day
    contest_board = ContestBoard.new(name)
    if contest_board.save
      render json: contest_board, status: 200
    else
      render json: {message: "The resource could not be created and saved."}
    end
  end
  
  def update
    #/contest_boards
    contest_board = ContestBoard.find_by(id: params[:id])
    if contest_board && contest_board.update(contest_board_params)
      render json: contest_board, status: 200
    else
      render json: {message: "The resource could not be retrieved and updated."}
    end
  end
  
  def destroy
    #/contest_boards
    contest_board = ContestBoard.find_by(id: params[:id])
    if contest_board
      contest.delete
      render json: {contest_board_id: contest_board.id, status: 200}
    else
      render json: {message: "The resource could not be retrieved and deleted."}
    end
  end


  private
  
  def contest_board_params
    params.require(:contest_board)    
  end
end
