require 'spec_helper'

describe UsersController do
  fixtures :users

  def mock_user
    @mock_user ||= mock_model(User)
  end

  def valid_user_attributes(attributes={})
    {
      :nome_completo => "Testando o teste",
      :username => "teste@teste.com.br",
      :password => "testando",
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
      :email => "claudia@ime.usp.br",
      :nome_completo => "Claudia Bananal Melo",
      :identidade => "123456",
      :data_de_nascimento => "26/10/89",
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
        @user = User.find_by_email("novo@teste.com.br")
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
    # SHOW
    #
    context "GET show" do
      it "Deve redirecionar para a pagina inicial" do
        get :show, :id => "1"
        response.should redirect_to(root_url)
      end
    end

    #
    # EDIT
    #
    context "POST edit" do
      it "Nao deve permitir a edicao de usuarios" do
        post :edit
        flash[:message].should == 'É preciso logar como administrador para editar dados de outros usuários.'
        response.should redirect_to(root_url)
      end
    end

    #
    # UPDATE
    #
    context "POST update" do
      it "Nao deve atualizar os dados do usuario" do
        post :update
        response.should_not be_success
      end
    end

    #
    # DESTROY
    #
    context "POST destroy" do
      it "Nao deve remover o usuario" do
        post :destroy, id => "2"
        @user = User.find_by_id("2")
        @user.should_not be_nil
      end

      it "Nao deve ter sucesso" do
        post :destroy, id => "2"
        response.should_not be_success
      end

      it "Deve redirecionar para a pagina inicial" do
        post :destroy, id => "2"
        flash[:message].should == 'É preciso logar como administrador para remover um usario.'
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
      #@user = User.find_by_id(2)
      login_as_user :claudia
      @user = current_user
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
        flash[:error].should == 'É necessário deslogar para criar um novo usuário.'
        response.should redirect_to root_url
      end

    end

    #
    # NEW
    #
    context "GET new" do
      it "Nao deve criar um novo usuario" do
        get :new
        response.should_not be_success
      end

      it "Deve redirecionar para a pagina inicial" do
        get :new
        response.should redirect_to root_url
      end
    end

    #
    # INDEX
    #
    context "GET index" do
     
      it "Usuarios que não sejam o admin nao podem listar os demais" do
        get :index
        flash[:message].should == 'Apenas os administradores podem verificar a lista de usuários.'
        response.should redirect_to(user_path(@user))
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


    #
    # EDIT
    #
    context "POST edit" do
      it "Usuário logado pode se editar" do
        post :edit
        response.should be_success
      end

       it "Deve redirecionar para a pagina do user" do
        post :edit
        response.should be_success
      end
    end

    #
    # UPDATE
    #
    context "POST update" do

      it "Apos atualizacao com sucesso, deve redirecionar para as inscricoes" do
        @user.should_receive(:update_attributes).and_return(true)
        post :update, :user => valid_update_attributes
        response.should redirect_to(user_subscriptions_url(@user))
      end

      it "Apos atualizacao com sucesso, deve redirecionar para as inscricoes" do
        @user.should_receive(:update_attributes).and_return(true)
        post :update, :user => valid_update_attributes
        flash[:message].should == 'Usuário alterado com sucesso!'
      end

      it "Tentativa de cobrir tudo" do
        post :update, :user => valid_update_attributes
        (@user.nome_completo).should == "Claudia Bananal Melo"
      end

      it "Usuário logado pode atualizar seus dados validos" do
        post :update, :user => valid_update_attributes(:nome_completo => "Claudia de Macieiras Melo")
        response.should be_success
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
      it "Nao deve remover o usuario" do
        post :destroy, :id => "2"
        @user = User.find_by_id("2")
        @user.should_not be_nil
      end

      it "Deve redirecionar para a pagina inicial" do
        post :destroy, :id => "2"
        flash[:message] = 'É preciso logar como administrador para remover um usario.'
        response.should redirect_to root_url
      end
    end
  end

   #
  # WITH ADMIN LOGGING
  #
  context "When ADMIN IS LOGGED IN: " do

    before :each do
      activate_authlogic
      @user_admin = User.find_by_id(3)
      login_as_user :admin
    end

    #
    # INDEX
    #
    
    it "O admin deve listar os usuarios" do
      @user = User.find_by_username("admin@ime.com.br")
      login_as_user :admin
      get :index
      response.should be_success
    end

    #
    # DESTROY
    #
    context "DELETE destroy" do
      it "Deve remover o usuario" do
        post :destroy, :id => "2"
        @user = User.find_by_id("2")
        @user.should be_nil
      end

      it "Deve redirecionar para a lista de usuarios" do
        post :destroy, :id => "2"
        response.should redirect_to(users_url)
      end

    end

  end

end





