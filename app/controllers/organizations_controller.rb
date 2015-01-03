class OrganizationsController < ApplicationController

  before_action :set_organization, only: :show

  def show
    @organization = Organization.find(params[:id])
    @goals = @organization.goals.paginate(page: params[:page])
  end

  def index
    @organizations = Organization.all
    @organization = Organization.new
  end


  def new
    @organization = Organization.new(parent_id: params[:parent_id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    #binding.pry
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to organizations_url, notice: 'Organizacion creada.' }
        format.json { render :index}
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end

  end



  private
  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = Organization.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def organization_params
    params.require(:organization).permit(:name, :parent_id)
  end

end
