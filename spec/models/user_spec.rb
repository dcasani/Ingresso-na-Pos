require 'spec_helper'

describe User do

  context "Validaçoes de nome:" do

    it "Deve validar um nome real" do
      @user = User.new(:nome_completo => 'George Daniel Casani Delgado')
      @user.should have(:no).errors_on(:nome_completo)
    end

    it "Não deve validar um nome abreviado" do
      @user = User.new(:nome_completo => 'George D. C. Delgado')
      @user.should have(1).errors_on(:nome_completo)
    end

    it "Deve validar um nome com acentos e caracteres latinos" do
      @user = User.new(:nome_completo => 'Álvaro Cássia João Cauê Cabëçada')
      @user.should have(:no).errors_on(:nome_completo)
    end

    it "Deve validar um nome com hífen" do
      @user = User.new(:nome_completo => 'Alinka François-Lépine')
      @user.should have(:no).errors_on(:nome_completo)
    end

    it "Não deve validar um nome real com espaço no começo" do
     # pending "Nomes com espaços nao estão passando" - esse teste parece estranho.
      @user = User.new(:nome_completo => '   George Daniel Casanbi delgado')
      @user.should have(1).errors_on(:nome_completo)
    end

    it "Não deve validar um nome real com espaço no final" do
     # pending "Nomes com espaços nao estão passando"
      @user = User.new(:nome_completo => 'George Daniel Casanbi Delgado     ')
      @user.should have(1).errors_on(:nome_completo)
    end

    it "Não deve validar um nome com presença de números" do
      @user = User.new(:nome_completo => 'George2Daniel')
      @user.should have(1).errors_on(:nome_completo)
    end

    it "Não deve validar um nome com caracteres estranhos" do
      @user = User.new(:nome_completo => '!@#$%^&*()-+\|=-~`[]{}')
      @user.should have(1).errors_on(:nome_completo)
    end

    it "Não deve validar um nome em branco" do
      @user = User.new(:nome_completo => '')
      @user.should have_at_least(1).errors_on(:nome_completo)
    end

  end

  context "Validaçoes de outros dados pessoais" do

    it "Deve validar um documento de identidade em branco" do
      @user = User.new(:identidade => '')
      @user.should have(:no).errors_on(:identidade)
    end

    it "Deve validar um documento de identidade com pontos e traços" do
      @user = User.new(:identidade => '999.999.999-69')
      @user.should have(:no).errors_on(:identidade)
    end

    it "Deve validar uma nacionalidade em branco" do
      @user = User.new(:nacionalidade => '')
      @user.should have(:no).errors_on(:nacionalidade)
    end

    it "Deve validar um cpf em branco" do
      @user = User.new(:cpf => '')
      @user.should have(:no).errors_on(:cpf)
    end

  end

  context "Validaçoes de endereço:" do

    it "Deve validar um logradouro permanente vazio" do
      @user = User.new(:logradouro_permanente => '')
      @user.should have(:no).errors_on(:logradouro_permanente)
    end

    it "Não deve validar um logradouro permanente com caracteres estranhos" do
      @user = User.new(:logradouro_permanente => '!@$%*()+=|\\#{}[]?><')
      @user.should have_at_least(1).errors_on(:logradouro_permanente)
    end

    it "Ddeve validar um número permanente vazio" do
      @user = User.new(:numero_permanente => '')
      @user.should have(:no).errors_on(:numero_permanente)
    end

    it "Deve validar códigos postais vazios" do
      @user = User.new(:cep_permanente => '')
      @user.should have(:no).errors_on(:cep_permanente)
    end

    it "Deve validar códigos postais que possuam apenas números" do
      @user = User.new(:cep_permanente => '1234567890')
      @user.should have(:no).errors_on(:cep_permanente)
    end

    it "Deve validar códigos postais que possuam números e traços" do
      @user = User.new(:cep_permanente => '12345-678')
      @user.should have(:no).errors_on(:cep_permanente)
    end

    it "Deve validar um número permanente que seja formado por números e letras" do
      @user = User.new(:numero_permanente => '23')
      @user.should have(:no).errors_on(:numero_permanente)

      @user = User.new(:numero_permanente => 'B')
      @user.should have(:no).errors_on(:numero_permanente)

      @user = User.new(:numero_permanente => '23b')
      @user.should have(:no).errors_on(:numero_permanente)
    end

    it "Deve validar uma cidade permanente vazio" do
      @user = User.new(:cidade_permanente => '')
      @user.should have(:no).errors_on(:cidade_permanente)
    end

    it "Deve validar um estado permanente vazio" do
      @user = User.new(:estado_permanente => '')
      @user.should have(:no).errors_on(:estado_permanente)
    end

    it "Deve validar um país permanente vazio" do
      @user = User.new(:pais_permanente => '')
      @user.should have(:no).errors_on(:pais_permanente)
    end

  end

end
