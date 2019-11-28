class Api::V1::ContestWeeksController < ApplicationController
  def index 
    @contest_weeks = ContestWeek.all
    render json: @contest_weeks, status: 200
  end

  def show
    @contest_week = ContestWeek.find_by(id: params[:id])
    if @contest_week
      render json: @contest_week
    else
      render json: {message: "The requested resource was not found"}
    end
  end

  def current
    contest_week = ContestWeek.all.last
    contest_props = ContestProp.filter_by_contest_week(contest_week)
    render json: contest_props, status: 200
  end
  
  def create
    @contest_week = ContestWeek.create(contest_week_params)
    render json: @contest_week, status: 200
  end
  
  def update
    @contest_week = ContestWeek.find_by(id: params[:id])
    @contest_week.update(contest_week_params)
    render json: @contest_week, status: 200
  end
  
  def destroy
    @contest_week = ContestWeek.find_by(id: params[:id])
    @contest.delete
    render json: {contest_week_id: @contest_week.id}
  end


  private
  
  def contest_week_params
    params.require(:contest_week).permit(:name)    
  end
end
