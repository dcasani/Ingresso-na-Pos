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

  def valid_new_user_attributes(attributes={})
    {
      :username => "novo@teste.com.br",
      :password => "novo",
      :formacao_superior_graduacao => "Bacharelado em Ciência da Computação",
    }.merge attributes
  end

  def valid_user_admin_attributes(attributes={})
    {
      :nome_completo => "Admin",
      :username => "admin@teste.com.br",
      :password => "admin",
      :formacao_superior_graduacao => "Bacharelado em Ciência da Computação",
    }.merge attributes
  end

  #
  # WITHOUT LOGGING
  #
  context "When user NOT LOGGED IN: " do

    #
    # CREATE
    #
    context "POST create" do

      after(:each) do
        @user = User.find_by_username("novo@teste.com.br")
        if(@user)
          @user.destroy
        end
      end

      it "Deve criar um usuário se não há nenhum logado." do
        pending
        post :create, :user => valid_new_user_attributes
        @user = User.find_by_username("novo@teste.com.br")
        @user.should_not be_nil
      end

      it "Deve redirecionar para uma nova inscrição após a criação do usuário." do
        pending
        post :create, valid_new_user_attributes
        response.should redirect_to(new_subscription_url)
      end

      it "Não deve criar um usuário com parâmetros inválidos" do
        post :create, :user => valid_user_attributes(:username => nil)
        User.find_by_email('teste@teste.com').should be_nil
        flash[:error].should == "Usuário não criado."
        response.should render_template(:new)
      end

      it "Não deve criar um usuário sem login" do
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
        @user = User.find_by_username("claudia@ime.usp.br")
        delete :destroy, :id => @user.id

        # Check wheter the user was successfuly destroyed
        User.find_by_username("claudia@ime.usp.br").should be_nil
        response.should redirect_to(users_url)
      end
    end

    #
    # SHOW
    #
    context "GET show" do
      it "should not show user info" do
        get :show, :id => "1"
        response.should redirect_to(root_url)
      end
    end
  end

  #
  # WITH LOGGING
  #
  context "When user LOGGED IN: " do

    before :each do
      login_as_user :teste
    end

    #
    # CREATE
    #
    context "POST create" do
      after(:each) do
        @user = User.find_by_username("teste2@teste.com.br")
        if(@user)
          @user.destroy
        end
      end

      

      it "Não deve criar um usuário se há algum logado e não é o administrador" do
        post :create, valid_new_user_attributes
        @new_user = User.find_by_username("teste2@teste.com.br")
        
        @new_user.should be_nil
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
        pending
        get :show, :id => "2"
        assigns[:user].should == users(:teste)
      end
    end
  end
   

    
  


  #
  # WITH ADMIN LOGGING
  #
  context "When ADMIN IS LOGGED IN: " do

    before :all do
      @user = User.find_by_id(3)
      login_as_user :admin
    end


  end


end

