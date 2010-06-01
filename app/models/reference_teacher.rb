class ReferenceTeacher < ActiveRecord::Base
  belongs_to :subscription

 validates_presence_of :nome, :instituicao, :email, :lingua,
                        :message => ": Preencher campo obrigatório"
 validates_format_of   :nome,
    :with => /\A[a-zA-Zá-úÁ-ÚçÇ-]+( [a-zA-Zá-úÁ-ÚçÇ-]+)*\Z/, :message => ": Usar somente letras e espaços"
 validates_format_of :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i , :message => ": Formato de email inválido"

end
