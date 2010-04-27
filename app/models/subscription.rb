class Subscription < ActiveRecord::Base
  belongs_to :user
  require 'paperclip'
  has_attached_file :diploma, :url => "/arquivos/diploma/:id/:basename.:extension"
  has_attached_file :historico, :url => "/arquivos/historico/:id/:basename.:extension"
  has_attached_file :poscomp, :url => "/arquivos/poscomp/:id/:basename.:extension"

  validates_presence_of :dados_carta_recomendacao

  #validates_format_of :bolsa_fomento, :bolsas_anteriores,
  #                    :with => /\A[a-zA-Zá-úÁ-ÚçÇ-]+( [a-zA-Zá-úÁ-ÚçÇ-]+)*\Z+\A\Z/, :message => ": Usar somente letras e espaços"

end
