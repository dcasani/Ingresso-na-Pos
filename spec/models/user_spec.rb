require 'spec_helper'

describe User do

  context "Validations:" do
    
    it "should validate a real name" do
      @user = User.new(:nome_completo => 'George')
      @user.should have(:no).errors_on(:nome_completo)
    end
    
  end
  
end
