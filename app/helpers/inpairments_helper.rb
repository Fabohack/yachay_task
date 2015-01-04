module InpairmentsHelper

  def format_Inpairment(inpairment)
    #binding.pry
    case inpairment.tipo

      when 'Observacion'
        content_tag(:label, 'Observacion', :class => "label pull-right label-success")
      when 'Impedimento'
        content_tag(:label, 'Impedimento', :class => "label pull-right label-warning")
      when 'Respuesta'
        content_tag(:label, 'Respuesta', :class => "label pull-right label-info")
    end
  end


end
