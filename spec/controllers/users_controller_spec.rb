require 'spec_helper'

describe UsersController do
  fixtures :users

  def mock_user
    @mock_user ||= mock_model(User)
  end

  def valid_attributes(attributes={})
    {
      :username => "teste@teste.com.br",
      :password => "teste",
      :formacao_superior_graduacao => "Bacharelado em Ciência da Computação",
    }.merge attributes
  end

context "GET new" do
    before :each do
      User.stub!(:new).and_return(mock_user)
      get :new
    end
    
    it "should be sucessful" do
      response.should be_success
    end

    it "should assign new user" do
      assigns[:user].should == mock_user
    end
  end

  context "POST create" do
    it "should create a user given valid attributes" do
      post :create, :user => valid_attributes
      user = User.find(1)
      user.should_not be_nil
     # flash[:notice].should == "Usuário criado com sucesso!"
     #  response.should redirect_to(new_subscription_url)
    end
  end

  context "GET show" do
    it "should show user attributes given an id" do
      pending
      get :show, :login => users(:teste)
      assigns[:user].should == users(:teste)
    end
  end

end

