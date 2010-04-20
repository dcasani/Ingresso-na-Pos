class Subscription < ActiveRecord::Base
  belongs_to :user
  require 'paperclip'
  has_attached_file :diploma, :url => "/arquivos/diploma/:id/:basename.:extension"
  has_attached_file :historico, :url => "/arquivos/historico/:id/:basename.:extension"
  has_attached_file :poscomp, :url => "/arquivos/poscomp/:id/:basename.:extension"
end
