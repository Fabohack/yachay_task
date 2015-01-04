class Inpairment < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  enum tipo: [:'Observacion', :'Impedimento', :'Respuesta']
end
