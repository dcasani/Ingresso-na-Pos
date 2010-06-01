# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'spec_helper'

describe UserSessionsController do
  fixtures :users

  def mock_session
    @mock_session ||= mock_model(UserSession)
  end

  def valid_attributes(attributes={})
    {
      :username => "teste@teste.com.br",
      :password => "teste",
    }.merge attributes
  end

  context "GET new" do
    before :each do
      UserSession.stub!(:new).and_return(mock_session)
      get :new
    end

    it "should assign to @user_session a new instance" do
      assigns[:user_session].should == mock_session
    end
  end
  
  context "POST create" do
    it "should create a new session given valid attributes" do
      post :create, :user_session => valid_attributes
      user_session = UserSession.find
      user_session.should_not be_nil
      user = user_session.user
      user.should == users(:teste)
      flash[:notice].should == "Usuário logado com sucesso!"
   #   response.should redirect_to(user_path(user.id))
    end

    it "should not create a new session given invalid attributes" do
      post :create, :user_session => valid_attributes(:username => "naoexisto")
      user_session = UserSession.find
      user_session.should be_nil
      flash[:message].should == "Usuário e/ou senha inválidos!"
      response.should render_template(:new)
    end
  end

  context "DELETE destroy" do
    it "should destroy the current session" do
      post :create, :user_session => valid_attributes
      delete :destroy
      (UserSession.find).should be_nil
     # flash[:message].should == 'Sessão finalizada com sucesso.'
      response.should redirect_to(root_url)
    end
  end

end

