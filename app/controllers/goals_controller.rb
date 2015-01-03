class GoalsController < ApplicationController
  #before_action :set_goal, only: [:show, :edit, :update, :destroy]

  def create
    @goal = Goal.new(goals_params)
    respond_to do |format|
      if @goal.save
        format.html { redirect_to goals_path , notice: 'Goal was successfully created.' }
        format.json { render json: @goal, status: :created, location: @goal }
      else
        format.html { render action: "new" }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @goals = Goal.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goals }
    end
  end

  def new
    @goal = Goal.new
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])

    respond_to do |format|
      if @goal.update(goals_params)
        format.html { redirect_to @goal, notice: 'Goal was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy

    respond_to do |format|
      format.html { redirect_to goals_url }
      format.json { head :ok }
    end
  end

  def show
    @goal = Goal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @goal }
    end
  end

  private

  #def set_goal
  #  @goal = Goal.find(params[:id])
  #end

  def goals_params
    params.require(:goal).permit(:name,:organization_id => [])
  end
end
