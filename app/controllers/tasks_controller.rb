class TasksController < ApplicationController
  respond_to :html, :xml, :json
  
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  #before_action :set_project

  def index
    case params[:scope]
      when ''
        @tasks =  Task.all.where("assigned_to_id = ?", current_user).order(deadline: :desc)
      else
        @project = Project.find(params[:project_id])
        @tasks = @project.tasks.order(deadline: :desc)
    end
    respond_with(@tasks)
  end

  def alltasks
    @tasks =  Task.all.order(deadline: :desc)
  end

  def assigned_to_me
      @tasks =  Task.all.where("assigned_to_id = ?", params[:scope]).order(project_id: :asc, deadline: :desc)
      #@tasks =  Task.all.where("assigned_to_id = ?", current_user).order(project_id: :asc, deadline: :desc)
  end

  def show
    respond_with(@task)
  end

  def new
    #binding.pry
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new
    #respond_with(@task)
  end

  def edit
    @project = Project.find(params[:project_id])

    #binding.pry
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)
    @task.user_id = current_user
    if @task.save
      redirect_to project_tasks_path(@project), notice:'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    @project = Project.find(params[:project_id])
    if @task.update(task_params)
      redirect_to project_tasks_path(@project), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully deleted.' }
      format.json { head :ok }
    end
  end

  private
     def set_task
       @task = Task.find(params[:id])
     end

    def task_params
      params.require(:task).permit(:description, :deadline, :complexity, :score, :state_id, :project_id,:assigned_to_id,:real_deadline)
    end

    #def set_project
    #  @project = Project.find(params[:project_id])
    #end
end
