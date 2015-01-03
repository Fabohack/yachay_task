class AlignmentsController < ApplicationController


  before_filter :authenticate_user!
  before_action :set_project


  def index

    @alignments = @project.alignments

  end

  def new

    @alignment = @project.alignments.new

  end

  def create

    @goal = Goal.find(params[:alignments][:goal_id])
    @alignment = @project.alignments.new(alignment_params)
    @alignment.goal = @goal
    #@membership.user = @user
    if @alignment.save
      redirect_to project_alignments_path(@project),
                  notice: "Objetivo assigned successfully!"
    else
      render :new
    end

  end

  private

    def set_project
      @project = Project.find(params[:project_id])
    end

    def alignment_params
      params.require(:alignment).permit(:goal_id,:project_id )
    end
end
