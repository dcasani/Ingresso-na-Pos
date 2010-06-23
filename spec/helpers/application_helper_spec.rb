require 'spec_helper'

describe ApplicationHelper do

  context "Mensagens de aviso, erro etc " do

    it "Após flash_helper deve apagar os avisos" do
      flash[:notice] = "Tem um erro aqui"
      helper.flash_helper
      flash[:notice].should be_nil
    end
  end
  
end
