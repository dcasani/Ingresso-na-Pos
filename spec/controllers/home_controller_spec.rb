# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'

describe HomeController do
#before(:each) do
#  @user_session = UserSession.new
#end
  
  it "Não deve validar um nome usuario em branco" do
      @user_session = UserSession.new(:email => '')
      @user_session.should have_at_least(1).errors_on(:email)
    end
#  it do
#    @user_session.should validate_presence_of(:password)
#  end

end

