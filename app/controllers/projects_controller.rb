class ProjectsController < ApplicationController
	before_filter :authenticate_user!
	respond_to :html, :xml, :json
	before_action :set_project, only: [:show, :edit, :update, :destroy]

	def index
    if current_user.admin?
      object=Project
    else
      object=current_user.projects
    end  
    @projects=general_filter(object,params[:scope])
  end 

	def show
    @openS = Project.open.where('is_strategic = ?',true)
    @openNS = Project.open.where('is_strategic = ?',false)
    @ClosedS = Project.closed.where('is_strategic = ?',true)
    @ClosedNS = Project.closed.where('is_strategic = ?',false)

    @goals = @project.goals
		respond_with(@project, @goals)
		#@goals = @project.goals
	end

	def new
	    @project = Project.new
	    respond_with(@project)
      
  	end

  	def edit
      @membership = Membership.all
  	end
  	
  	def create
	    @project = Project.new(project_params)
	    flash[:notice] = 'Project was successfully created.' if @project.save
	    respond_with(@project)
  	end

  	def update
  		flash[:notice] = 'Project was successfully updated.' if @project.update(project_params)
  		respond_with(@project)
  	end

  	def destroy
  		@project.destroy
  		respond_with(@project)
  	end

  	private

	    def set_project
	      @project = Project.find(params[:id])
	    end

	    def project_params
	      params.require(:project).permit(:name, :description, :price, :is_strategic, :status,:is_critical,:alias,:remark,:estimated_start_date,:estimated_end_date,:real_start_date,:real_end_date, :goal_ids=>[])
	    end

  protected 
  
  def general_filter(object,criteria)
    case criteria
      when 'all'
        filter = object.all
      when 'closed'
        filter = object.closed
      when 'suspended'
        filter = object.suspended
      when 'transferred'
        filter = object.transferred
      when 'open_is_strategic'
        filter = object.open.where('is_strategic = ?',true)
      when 'open_is_not_strategic'
        filter = object.open.where('is_strategic = ?',false)
      when 'closed_is_strategic'
        filter = object.closed.where('is_strategic = ?',true)
      when 'closed_is_not_strategic'
        filter = object.closed.where('is_strategic = ?',false)
      when 'open_is_critic'
        filter = object.open.where('is_critical = ?',true)
      when 'open_is_not_critic'
        filter = object.open.where('is_critical = ?',false)
      when 'closed_is_critic'
        filter = object.closed.where('is_critical = ?',true)
      when 'closed_is_not_critic'
        filter = object.closed.where('is_critical = ?',false)
      else
        filter = object.open
    end
    return filter
  end
end
