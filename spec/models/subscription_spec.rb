require 'spec_helper'

describe Subscription do
  before(:each) do
    @valid_attributes = {
      :inicio_pretendido => "março"
    }
    @subscription = Subscription.new(@valid_attributes)
  end
  
  context "validacao de criacao da instancia" do
    it "deve criar uma nova instância corretamente" do
      @subscription.should have(:no).errors
    end
  end

  context "validacao de inicio pretendido" do
     it "Não deve aceitar inicio pretendido vazio" do
       @subscription = Subscription.new(:inicio_pretendido => '')
       @subscription.should have_at_least(1).errors_on(:inicio_pretendido)
     end
  end

  context "validacao de outros programas" do
    it "deve validar outros_programas vazio" do
     @subscription = Subscription.new(:outros_programas => "")
     @subscription.should have(:no).errors_on(:outros_programas)
   end
  end

  context "validacao do orientador" do
    it "Deve aceitar orientador vazio" do
      @subscription = Subscription.new(:orientador => "")
      @subscription.should have(:no).errors_on(:orientador)
    end

    it "Deve aceitar nome de orientador valido e abreviado" do
      @subscription = Subscription.new(:orientador => "Amado P. Nervo")
      @subscription.should have(:no).errors_on(:orientador)
    end
  end

  context "validacao do bolsas" do
    it "Deve aceitar solicitacao de bolsa vazia" do
      @subscription = Subscription.new(:bolsa_fomento => "")
      @subscription.should have(:no).errors_on(:bolsa_fomento)
  end

    it "Deve aceitar bolsas anteriores vazias" do
      @subscription = Subscription.new(:bolsas_anteriores => "")
      @subscription.should have(:no).errors_on(:bolsas_anteriores)
    end
  end

  context "validacao de cartas de recomendacao" do
    it "Deve aceitar carta de recomendação em branco" do
      pending
    end
  end

 context "Validacao da situacao profissional" do
    it "Deve aceitar resposta vazia na pergunta continuar trabalhando se aceito" do
      @subscription = Subscription.new(:trabalhar_se_aceito => '')
      @subscription.should have(:no).errors_on(:trabalhar_se_aceito)
    end
  end

  context "Validacao do resumo da dissertacao" do
    it "Deve aceitar resumo da dissertacao de mestrado em branco" do
      @subscription = Subscription.new(:resumo_dissertacao_mestrado => '')
      @subscription.should have(:no).errors_on(:resumo_dissertacao_mestrado)
    end
  end

  context "Validacao da Exposiçao de propósitos" do
    it "Não deve aceitar exposiçao de propósitos em branco" do
      @subscription = Subscription.new(:propositos => '')
      @subscription.should have_at_least(1).errors_on(:propositos)
    end
  end

  context "Validacao das observaçoes" do
    it "Deve aceitar observaçoes em branco" do
      @subscription = Subscription.new(:observacoes => '')
      @subscription.should have(:no).errors_on(:observacoes)
    end
  end


end