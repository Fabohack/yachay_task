module ProjectsHelper

	def alignment(align)
		if align===''
			opc_align=align
		else
			opc_align='pull-'+align
		end
		return opc_align
	end

	def format_description(project)
		content_tag(:strong, project.description)
  end

  def format_remark(project)
    content_tag(:strong, project.remark)
  end

	def format_budget(project)
		if project.estimated?
			content_tag(:p, 'not estimated')
		else
			content_tag(:p, humanized_money_with_symbol(project.price))
		end
	end

  def format_critical(var,align)
    opc_align=alignment(align)
    if var.is_critical?
      content_tag(:label, 'Critic', :class => "label #{opc_align} label-warning")
    else
      content_tag(:label, 'No Critic', :class => "label #{opc_align} label-success")
    end
  end

  def format_is_critical(project,align)
    if project.is_critical?
      opc_align=alignment(align)
      content_tag(:span, 'Critic', :class => "label #{opc_align} label-warning")
    end
  end

	def format_is_strategic(project,align)
		if project.is_strategic?
			opc_align=alignment(align)
			content_tag(:span, 'Strategic', :class => "label #{opc_align} label-default")
		end
	end

  def format_status_pro(p,align)
    opc_align=alignment(align)
    case p.status
      when 0
        content_tag(:span, 'open', :class => "label #{opc_align} label-progress")
      when 1
        content_tag(:span, 'closed', :class => "label #{opc_align} label-success")
      when 2
        content_tag(:span, 'suspended', :class => "label #{opc_align} label-default")
      else
        content_tag(:span, 'transferred', :class => "label #{opc_align} label-warning")
    end
  end

	def format_status(project,align)
		opc_align=alignment(align)
		case project.status
		when 'open'
  			content_tag(:span, 'open', :class => "label #{opc_align} label-info")
		when 'closed'
  			content_tag(:span, 'closed', :class => "label #{opc_align} label-success")
		when 'suspended'
      		content_tag(:span, 'suspended', :class => "label #{opc_align} label-default")
  		else
  			content_tag(:span, 'transferred', :class => "label #{opc_align} label-warning")
    end
	end
end
