class User < ActiveRecord::Base
  has_many :subscriptions
  validates_presence_of :nome_completo, :identidade, :data_de_nascimento,
                        :identidade, :tipo, :nacionalidade, :logradouro_permanente,
                        :numero_permanente, :cidade_permanente, :estado_permanente,
                        :pais_permanente, :logradouro_correspondencia,
                        :numero_correspondencia, :cidade_correspondencia,
                        :estado_correspondencia, :pais_correspondencia,
                        :email, :formacao_superior_graduacao , :message => ": Preencher campo obrigatório"

                      # Campos de texto formados apenas por palavras (sem números nem caracteres especiais)
  validates_format_of :nome_completo, :tipo, :nacionalidade, :cidade_permanente,
                      :estado_permanente, :pais_permanente, :cidade_correspondencia,
                      :estado_correspondencia, :pais_correspondencia, :formacao_superior_graduacao,
                      :with => /\A[a-zA-Zá-úÁ-ÚçÇ-]+( [a-zA-Zá-úÁ-ÚçÇ-]+)*\Z/, :message => ": Usar somente letras e espaços"

                      # Campos formados por palavras e sinais de pontuação (.,-)
  validates_format_of :logradouro_permanente, :logradouro_correspondencia,
                       :with => /\A[a-zA-Zá-úÁ-ÚçÇ-]+( [-,.]? ?[a-zA-Zá-úÁ-ÚçÇ-]+)*\Z/, :message => ": Usar somente letras e espaços"

  validates_format_of :numero_permanente, :numero_correspondencia,
                      :with => /\A[A-Za-z0-9]+\Z/, :message => ": Usar somente números e letras, sem espaços."

  #validates_format_of :email, :with => /^[-_a-z0-9]+(\\.[-_a-z0-9]+)*\\@([-a-z0-9]+\\.)*([a-z]{2,4})$/, :message => ": Formato de email inválido"
  #validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i , :message => ": Formato de email inválido"
  validates_format_of :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i , :message => ": Formato de email inválido"

  #validate_length_of :nome_completo, :in => 2..150

  validates_uniqueness_of :identidade

end
