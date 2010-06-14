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

  def valid_update_attributes(attributes={})
    {
        :username => "claudia@ime.usp.br",
        :password => "abcdef",
        :nome_completo => "Claudia Melo",
        :identidade => "1234567",
        :data_de_nascimento => "26/10/89",
        :email => "claudia@ime.usp.br",
        :formacao_superior_graduacao => "Bacharelado em Ciência da Computação"
    }.merge attributes
  end

  #
  # WITHOUT LOGGING
  #
  context "When user NOT LOGGED IN: " do


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
        @user = mock_user()
        @user = valid_new_user_attributes
        User.should_receive(:new).and_return(@user)
        @user.should_receive(:save).and_return(true)
        @user.should_receive(:email).and_return("novo@teste.com.br")
        @user.should_receive(:username=)
        post :create
        @user.should_not be_nil
      end

      it "Deve redirecionar para uma nova inscrição após a criação do usuário." do
        @user = mock_user()
        @user = valid_new_user_attributes
        User.should_receive(:new).and_return(@user)
        @user.should_receive(:save).and_return(true)
        @user.should_receive(:email).and_return("novo@teste.com.br")
        @user.should_receive(:username=)
        post :create
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
   # INDEX
   #
   context "GET index" do
      it "Deve logar como administrador para listar os usuarios" do
       get :index
       flash[:message].should == 'É preciso logar como administrador para verificar a lista de usuários.'
       response.should redirect_to(root_url)
      end

   end

    #
    # EDIT
    #
    context "POST edit" do
      it "" do
        post :edit
        flash[:message].should == 'É preciso logar como administrador para verificar dados de usuários.'
        response.should redirect_to(root_url)
      end
    end

    #
    # UPDATE
    #
    context "POST update" do
      it "" do
        post :update
        response.should be_success
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
       activate_authlogic
       @user = User.find_by_id(2)
       login_as_user :claudia
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

      it "Deve redirecionar para a página principal"do
        post :create, valid_new_user_attributes
        @new_user = User.find_by_username("teste2@teste.com.br")
        flash[:error].should == 'É necessário deslogar para criar um novo usuário.'
        response.should redirect_to root_url
      end

    end

    #
    # NEW
    #
    context "GET new" do
      it "should not be sucessful" do
        pending
        get :new
        response.should_not be_success
      end
    end


   #
   # INDEX
   #
   context "GET index" do
      it "O admin deve listar os usuarios" do
       @user = User.find_by_username("admin@ime.com.br")
       login_as_user :admin
       get :index
       response.should be_success
      end

      it "Usuarios que não sejam o admin nao podem listas os demais" do
       get :index
       flash[:message].should == 'Apenas os administradores podem verificar a lista de usuários.'
       response.should redirect_to(user_path(@user))
      end
   end

     #
    # EDIT
    #
    context "POST edit" do
      it "Usuário logado pode se editar" do
        post :edit
        response.should be_success
      end
    end

    #
    # UPDATE
    #
    context "POST update" do

      it "Usuário logado pode atualizar seus dados validos" do
        pending
        #@user = mock_user
        #@user.should_receive(:email).and_return("claudia@ime.usp.br")
        #tanana.should_receive(:current_user).and_return(@user)
        #@user = valid_update_attributes
        #@user.should_receive(:update_attributes).and_return(true)
        post :update#, :user => valid_update_attributes
        #flash[:notice].should == 'Usuário alterado com sucesso!'
        response.should redirect_to(user_subscriptions_url(@user))
      end

      it "Usuario logado não pode atualizar dados nao validos" do
        post :update, :user => valid_user_attributes(:username => "")
        response.should render_template(:edit)
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
        get :show, :id => "2"
        assigns[:user].should == users(:claudia)
      end

      it "Um usuario nao deve poder verificar dados de outros usuarios" do
        get :show, :id => "1"
        flash[:message].should == 'Apenas o administrador pode verificar dados de outros usuários.'
        response.should redirect_to(user_path(@user))
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

