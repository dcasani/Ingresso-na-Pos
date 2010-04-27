require 'spec_helper'

describe Subscription do
  before(:each) do
    @valid_attributes = {
      :inicio_pretendido => "março"
    }
    @subscription = Subscription.create(@valid_attributes)
  end
  context "validacao de criacao da instancia" do
  it "deve criar uma nova instância corretamente" do
    @subscription.should have(:no).errors
  end
  end

 # context "validacao de inicio pretendido" do
 #   it "deve aceitar inscricao contínua no doutorado"
 #   it "deve aceitar apenas datas específicas de início pretendido no mestrado."
 # end

  context "validacao de outros programas" do
    it "deve validar outros_programas vazio" do
     @subscription.outros_programas = ""
     @subscription.should have(:no).errors_on(:outros_programas)
   end
  end

  context "validacao do orientador" do
    it "Deve aceitar orientador vazio" do
      @subscription.orientador = ""
      @subscription.should have(:no).errors_on(:orientador)
    end

    it "Deve aceitar nome de orientador valido" do
      @subscription.orientador = "Amado Nervo"
      @subscription.should have(:no).errors_on(:orientador)
    end
  end

  context "validacao do bolsas" do
    it "Deve aceitar solicitacao de bolsa vazia" do
      @subscription.bolsa_fomento = ""
      @subscription.should have(:no).errors_on(:bolsa_fomento)
  end

    it "Deve aceitar bolsas anteriores vazias" do
      @subscription.bolsas_anteriores = ""
      @subscription.should have(:no).errors_on(:bolsas_anteriores)
    end
  end

  context "validacao de cartas de recomendacao" do

    it "Não deve aceitar carta de recomendação em branco" do
      @subscription = Subscription.new(:dados_carta_recomendacao => '')
      @subscription.should have_at_least(1).errors_on(:dados_carta_recomendacao)
end
  end

end