class StatisticsController < ApplicationController
 def show
    if current_user.admin? 
      @projects = Project.open
    else
      @projects = current_user.projects.open
    end  	
  end

  def index
    if current_user.admin?
      object=Project
    else
      object=current_user.projects
    end  
    @projects=general_filter(object,params[:scope])
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
  
  def details
  end	
end
