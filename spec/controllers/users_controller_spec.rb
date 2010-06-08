require 'spec_helper'

describe UsersController do
  fixtures :users

  def mock_user
    @mock_user ||= mock_model(User)
  end

  def valid_user_attributes(attributes={})
    {
      :username => "teste@teste.com.br",
      :password => "teste",
      :formacao_superior_graduacao => "Bacharelado em Ciência da Computação",
    }.merge attributes
  end

  #
  # INDEX
  #
  context "GET index" do
    it "should list current users (not available in final version)" do
      pending
    end
  end


  #
  # WITH LOGGING
  #
  context "When user LOGGED IN: " do

    before :each do
      @user = User.find_by_id(1)
      login_as_user :teste
    end

    #
    # CREATE
    #
    context "POST create" do
      it "should not create a user" do
        pending
      end
    end

    #
    # NEW
    #
    context "GET new" do
      it "should not be sucessful" do
        pending
      end
    end

    #
    # DESTROY
    #
    context "DELETE destroy" do
      it "should not remove user" do
        pending
      end
    end

    #
    # SHOW
    #
    context "GET show" do
      it "should show user attributes given an id" do
        get :show, :id => '1'
        assigns[:user].should == users(:teste)
      end
    end
  end
   

    
  #
  # WITHOUT LOGGING
  #
  context "When user NOT LOGGED IN: " do

    #
    # CREATE
    #
    context "POST create" do

      it "should create a user given valid attributes" do
        post :create, :user => valid_user_attributes
        user = User.find_by_username("teste@teste.com.br")
        user.should_not be_nil
        #flash[:message].should == "Usuário criado com sucesso!"
        #response.should redirect_to( new_subscription_url)
      end

      it "should not create a user given invalid username" do
        post :create, :user => valid_user_attributes(:username => nil)
        User.find_by_email('teste@teste.com').should be_nil
        flash[:error].should == "Usuário não criado."
        response.should render_template(:new)
      end

      it "should not create a user given empty username" do
        post :create, :user => valid_user_attributes(:username => "")
        User.find_by_email('teste@teste.com').should be_nil
        flash[:error].should == "Usuário não criado."
        response.should render_template(:new)
      end
    end

    #
    # NEW
    #
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

    #
    # DESTROY
    #
    context "DELETE destroy" do
      it "should remove user (should change for final version)" do
        pending
        #        # Create a user
        #        @user = mock_user
        #        User.should_receive(:find).and_return(@user)
        #        # Save new user id
        #        @id = @user.id
        #        # Destroy user
        #        @user.should_receive(:destroy)
        #        delete :destroy, @user.id
        #
        #        # Check wheter the user was successfuly destroyed
        #        (User.find_by_id(@id)).should be_nil
        #        response.should redirect_to(users_url)
      end
    end

    #
    # SHOW
    #
    context "GET show" do
      it "should not show user info" do
        get :show, :id => "1"
        assigns[:user].should != users(:teste)
      end
    end
  end
end

