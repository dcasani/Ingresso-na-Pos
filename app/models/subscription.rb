class Subscription < ActiveRecord::Base

  has_many :reference_teachers
  belongs_to :user

  require 'paperclip'
  has_attached_file :diploma, :url => "/arquivos/diploma/:id/:basename.:extension"
  has_attached_file :historico, :url => "/arquivos/historico/:id/:basename.:extension"
  has_attached_file :poscomp, :url => "/arquivos/poscomp/:id/:basename.:extension"

  validates_presence_of :propositos, :inicio_pretendido,
                        :message => ": Preencher campo obrigatório"

  validates_format_of :inicio_pretendido,
                      :with => /\A[ a-zA-Zá-úÁ-ÚçÇ]*\Z/ , :message => ": Usar somente letras"

  validates_format_of :orientador,
                      :with => /\A[ a-zA-Zá-úÁ-ÚçÇ\.-]*\Z/, :message => ": Usar somente letras e espaços"



  #validates_format_of :bolsa_fomento, :bolsas_anteriores,
  #                    :with => /\A[a-zA-Zá-úÁ-ÚçÇ-]+( [a-zA-Zá-úÁ-ÚçÇ-]+)*\Z+\A\Z/, :message => ": Usar somente letras e espaços"

end
