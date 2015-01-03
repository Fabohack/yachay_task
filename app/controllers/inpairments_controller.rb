class InpairmentsController < ApplicationController

  respond_to :html, :xml, :json
  before_action :set_inpairment, only: [:show, :edit, :update, :destroy]

  def index
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:task_id])
    @inpairments = @task.inpairments
    respond_with(@inpairments)
  end

  def impairments
      @inpairments = Inpairment.find_by_sql("select projects.id as id_pro, projects.name,projects.description as descPro,projects.is_critical,projects.status ,tasks.description as taskdesc,tasks.id as task_id,inpairments.id as inpa_id,inpairments.description as inpadesc from tasks,inpairments,projects where inpairments.task_id = tasks.id and projects.id = tasks.project_id order by projects.id ASC")
  end

  def show
    respond_with(@inpairment)
  end

  def new
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:task_id])
    @inpairment = @task.inpairments.new

  end

  def edit
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:task_id])
    @inpairment = @task.inpairments.find(params[:id])
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:task_id])
    @inpairment = @task.inpairments.new(inpairment_params)
    @inpairment.user_id = current_user

    if @inpairment.save
      redirect_to project_task_inpairments_path(@project,@task), notice:'Inpairment was successfully created.'
    else
      render :new
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:task_id])
    @inpairment =  @task.inpairments.find(params[:id])

    if @inpairment.update(inpairment_params)
      redirect_to project_task_inpairments_path(@project,@task), notice:'Inpairment was successfully updated.'
    else
        format.html { render action: "edit" }
        format.js { render json: @inpairment.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:task_id])
    @inpairment=@task.inpairments.find(params[:id])
    @inpairment.destroy

    respond_to do |format|
      format.html { redirect_to project_task_inpairments_path(@project,@task), notice: 'Inpairment was successfully deleted.' }
      format.json { head :ok }
    end

  end

  private
    def set_inpairment
      @inpairment = Inpairment.find(params[:id])
    end

    def inpairment_params
      params.require(:inpairment).permit(:description,:project_id,:task_id)
    end

end
