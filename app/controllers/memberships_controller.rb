class MembershipsController < ApplicationController
	
	before_filter :authenticate_user!
	before_action :set_project

	def index
		@memberships = @project.memberships.order(responsible_role: :desc)
	end

	def new
		@membership = @project.memberships.new
	end

	def create
		#binding.pry
		@user = User.find(params[:memberships][:user_id])
		@membership = @project.memberships.new(membership_params)
		@membership.user = @user
		if @membership.save
			redirect_to project_memberships_path(@project),
			notice: "User assigned successfully!"
		else
			render :new
		end
	end

  def destroy
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.find(params[:id])
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to project_memberships_path(@project), notice: 'Membership was successfully deleted.' }
      format.json { head :ok }
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

	def membership_params
		params.require(:membership).permit(:responsible_role, :user_id, :project_id)
	end

end
