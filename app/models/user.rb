class User < ActiveRecord::Base

  # Aggregations
  has_many :subscriptions
  has_many :reference_teachers, :through => :subscriptions

  # Authlogic
  acts_as_authentic

  validates_presence_of :nome_completo, :data_de_nascimento, :email,
    :formacao_superior_graduacao,
    :message => ": Preencher campo obrigatório"

  # Campos de texto formados apenas por palavras (sem números nem caracteres especiais)
  validates_format_of :nome_completo,
    :with => /\A[a-zA-Zá-úÁ-ÚçÇ-]+( [a-zA-Zá-úÁ-ÚçÇ-]+)*\Z/, :message => ": Usar somente letras e espaços"


  validates_format_of :identidade,
    :with => /\A([a-z0-9-]+)*\Z/i, :message => ": Usar somente letras, números, . e -"

  validates_format_of :tipo, :nacionalidade, :cidade_permanente,
    :estado_permanente, :pais_permanente, :cidade_correspondencia,
    :estado_correspondencia, :pais_correspondencia,
    :with => /\A[ a-zA-Zá-úÁ-ÚçÇ-]*\Z/, :message => ": Usar somente letras e espaços."

  # Campos formados por palavras e sinais de pontuação (.,-)
  validates_format_of :logradouro_permanente, :logradouro_correspondencia,
    :with => /\A[a-zA-Zá-úÁ-ÚçÇ0-9-]*( [-,.]? ?[a-zA-Zá-úÁ-ÚçÇ0-9-]+)*\Z/, :message => ": Usar somente letras e espaços"

  validates_format_of :cep_permanente, :cep_correspondencia,
    :with => /\A[0-9-]*\Z/, :message => ":Usar apenas números no código postal"

  validates_format_of :numero_permanente, :numero_correspondencia,
    :with => /\A[A-Za-z0-9]*\Z/, :message => ": Usar somente números e letras, sem espaços."

  #validates_format_of :email, :with => /^[-_a-z0-9]+(\\.[-_a-z0-9]+)*\\@([-a-z0-9]+\\.)*([a-z]{2,4})$/, :message => ": Formato de email inválido"
  #validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i , :message => ": Formato de email inválido"
  #validates_format_of :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i , :message => ": Formato de email inválido"

  #validate_length_of :nome_completo, :in => 2..150

  #validates_uniqueness_of :email, :message => ": Já existe um usuário cadastrado com esse e-mail, por favor, escolha outro"

  # Função para verificação do CPF
  def validate
    cpf_string = cpf.to_s
    
    cpf_string.gsub!(/[^0-9]/,'')
    #errors.add_to_base "CPF string:" + cpf_string
    #errors.add_to_base "CPF class:" + cpf.class.to_s
    controle = ""
    digito = cpf_string.slice(-2,2)

    if cpf_string.size > 0
      # Permite CPF em branco
      if cpf_string.size == 11
        fator = 0
        2.times do |i|
          soma = 0
          9.times do |j|
            soma += cpf_string.slice(j,1).to_i * (10 + i - j)
          end
          soma += (fator * 2) if i == 1
          fator = (soma * 10) % 11
          fator = 0 if(fator == 10)
          controle << fator.to_s
        end
      elsif cpf_string.size > 0
        errors.add(:cpf, "inválido: dígitos faltando.")
      end

      if (controle != digito)
        errors.add(:cpf, "inválido: dígito verificador não confere.")
      end
    end
  end
end
