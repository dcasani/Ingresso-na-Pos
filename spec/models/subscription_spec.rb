require 'spec_helper'

describe Subscription do
  before(:each) do
    @valid_attributes = {
      :inicio_pretendido => "março"
    }
    @subscription = Subscription.create!(@valid_attributes)
  end

  it "deve criar uma nova instância corretamente" do
    Subscription.create!(@valid_attributes)
  end

  context "validacao de inicio pretendido" do
    it "deve aceitar inscricao contínua no doutorado"
    it "deve aceitar apenas datas específicas de início pretendido no mestrado."
  end

  it "deve validar outros_programas vazio" do
    @subscription.outros_programas = ""
    @subscription.should have(:no).errors_on(:outros_programas)
  end

end