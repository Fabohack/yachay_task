module StatisticsHelper
 	def generate_chart_bars(projects)
		chart=[['Projects', 'Progress', 'Remaining', 'Link']]
		row=1
		projects.each do |project|
			tasks=project.tasks
			stats=calculate_statistics(tasks)
			chart[row]=[project.name,stats,(1.to_f - stats.to_f), project_tasks_path(project)]
			#      puts "fila: #{row}"
			row+=1
		end	

		return chart
	end  
  
  def generate_bar(project)    
    width_value=calculate_percentage_statistics(project.tasks).to_i
    link_project=project_tasks_path(project)
    if width_value == 0
      prog_bar="progress-bar-info"
      value=100
    else     
      if calculate_task_delayed(project.tasks) == true
        prog_bar="progress-bar-danger"
      else
        prog_bar="progress-bar-success"
      end
      value=width_value
    end
    html="<div class='progress'><a href=#{link_project}><div class='progress-bar #{prog_bar}' role='progressbar' aria-valuemin='#{value}' aria-valuemax='100' style='width: #{value}%'>#{width_value}%</div></a></div>"
  end

  def calculate_task_delayed(tasks)
    value=false
    state="CERRADA"
    tasks.each do |task|
      if task.deadline.present?
        date_actual=DateTime.now.to_date.to_s
        date_dl_task=task.deadline.to_date.to_s     
        if (date_dl_task < date_actual) && (task.state.name != state)
          value=true
        end
      end
    end

    return value
  end

  def flag_project(tasks)
    if calculate_task_delayed(tasks) == true
      content_tag(:span, '',:class=>"glyphicon glyphicon-flag delayed")
    end
  end
  
  def complexity_value(task)
    return task[:complexity].to_f + 1
  end 

  def calculate_percentage_statistics(tasks)
    percentage=(calculate_statistics(tasks)*100).to_f.round(2)
  end

  def calculate_statistics(tasks)
    #Status {'OPEN'=>1,'CLOSE'=>2,'DELAYED'=>3,'IN_PROGRESS'=>4}
    #Complexity {'EASIER'=>1,'EASY'=>2,'MEDIUM'=>3,'DIFICULT'=>4,'VERY_DIFICULT'=>5}
    states = State.all.order(id: :asc)
    if tasks[0].nil?
      value=0
    else
      sum_complexity_work=0
      sum_open_work=0
      sum_closed_work=0
      sum_delayed_work=0
      sum_in_progress_work=0
      sum_work=0

      tasks.each do |task|
        sum_complexity_work+=complexity_value(task)
        case (task.state.name)
        when states[0].name
          #'OPEN'
          sum_open_work+=complexity_value(task)
        when states[1].name
          #'CLOSED'
          sum_closed_work+=complexity_value(task)
        when states[2].name
          #'DELAYED'
          sum_delayed_work+=complexity_value(task)
        when states[3].name
          #'IN PROGRESS'
          sum_in_progress_work+=complexity_value(task)
        end      
      end
      
  #   puts "======================="
  #   puts 'total'
  #   puts sum_completed_work
  #   puts sum_work
      percent_work=sum_closed_work.to_f/sum_complexity_work.to_f
      #   puts "%5.2f" % percent_#   
      puts "percent_work= #{percent_work.round(3)}"
      value=percent_work.to_f.round(3)
    end
    return value
  end

  def calculate_high_chart(projects)
    default_value=80
    total_projects=default_value * projects.count
  end

  def calculate_estimates_work(tasks)
    sum_work=0
    tasks.each do |task|
      sum_work+=task.estimated_work
    end
    return sum_work
  end

  def calculate_completed_work(tasks)
    sum_work=0
    tasks.each do |task|
      sum_work+=task.completed_work
    end
    return sum_work
  end

  def calculate_remaining_work(tasks)
    sum_work=0
    tasks.each do |task|
      sum_work+=task.remaining_work
    end
    return sum_work
  end

  def is_member_assigned(project)
    if project.memberships.where(responsible_role: "Principal")[0].nil?
      member='No one assigned'
    else
      member=project.memberships.where(responsible_role: "Principal")[0].user.email.split("@")[0]
    end
    return member
  end
end
