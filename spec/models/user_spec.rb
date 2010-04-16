require 'spec_helper'

describe User do

  context "Validaçoes:" do

    it "Deve validar um nome real" do
      @user = User.new(:nome_completo => 'George Daniel Casanbi Delgado')
      @user.should have(:no).errors_on(:nome_completo)
    end

    it "Não deve validar um nome abreviado" do
      @user = User.new(:nome_completo => 'George D. C. Delgado')
      @user.should have(1).errors_on(:nome_completo)
    end

    it "Deve validar um nome com acentos" do
      pending 
      @user = User.naew(:nome_completo => 'Cássia Garcia Ferreira')
      @user.should have(:no).erros_on(:nome_completo)
    end

    it "Não deve validar um nome real com espaço no começo" do
     # pending "Nomes com espaços nao estão passando"
      @user = User.new(:nome_completo => '   George Daniel Casanbi delgado')
      @user.should have(1).errors_on(:nome_completo)
    end

    it "Não deve validar um nome real com espaço no final" do
     # pending "Nomes com espaços nao estão passando"
      @user = User.new(:nome_completo => 'George Daniel Casanbi delgado ')
      @user.should have(1).errors_on(:nome_completo)
    end

    it "Não deve validar um nome com presença de números" do
      @user = User.new(:nome_completo => 'George2Daniel')
      @user.should have(1).errors_on(:nome_completo)
    end
    
  end
  
end
