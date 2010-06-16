require 'spec_helper'

describe SubscriptionsController do
  fixtures :users, :courses, :subscriptions

  def mock_user(stubs = {})
    @mock_user ||= mock_model(User, stubs)
  end

  def mock_subscription()
    @mock_subscription ||= mock_model(Subscription)
  end

  def mock_reference_teacher()
    @mock_reference_teacher ||= mock_model(ReferenceTeacher)
  end

  def mock_course()
    @mock_course ||= mock_model(Course)
  end

  def mock_user_session()
    @user_session ||= mock_model(UserSession)
  end

  def valid_login(attributes={})
    {
      :username => 'cassia@usp.br',
      :password => 'silvia'
    }.merge attributes
  end

  def valid_users_attributes(attributes={})
    {
      :username => "teste@teste.com.br",
      :password => "teste",
      :formacao_superior_graduacao => "Bacharelado em Ciência da Computação"
    }.merge attributes
  end

  def valid_subscription_attributes(attributes={})
    {
      :outros_programas => 'lala',
      :orientador => 'professor',
      :bolsa_fomento => 'lala',
      :bolsa_ime => 'true' ,
      :bolsas_anteriores => 'lala' ,
      :trabalhar_se_aceito => 'false' ,
      :resumo_dissertacao_mestrado => 'nao tenho' ,
      :observacoes => 'bla',
      :curso_id => '1',
      :inicio_pretendido => 'agosto',
      :propositos => 'bla bla bla'
    }.merge attributes
  end

  def invalid_subscription_attributes(attributes={})
    {
      :inicio_pretendido => '',
      :propositos => 'bla bla bla'
    }.merge attributes
  end

  def valid_course_attributes(attributes={})
    {
      :id => '1',
      :area => 'Computação',
      :nivel => 'Mestrado',
      :subarea => 'Bioinformática'
    }.merge attributes
  end

  def valid_course2_attributes(attributes={})
    {
      :id => '1',
      :area => 'Computação',
      :nivel => 'Doutorado',
      :subarea => 'Bioinformática'
    }.merge attributes
  end

  context "WHEN LOGGED IN" do
    before :each do
      activate_authlogic
      @user = User.find_by_id(1)
      login_as_user :teste
    end

    #
    #INDEX
    #
    context "GET index" do

      it "Index deve ter sucesso" do
        get :index
        response.should be_success
      end
      
    end

    #
    #SHOW
    #
    context "GET show" do
      
      it "Deve mostrar todas as subscriptions e seus professores recomendantes sem problemas" do
        @subscription = mock_subscription
        Subscription.should_receive(:find).and_return(@subscription)
        @course = mock_course
        @subscription.should_receive(:curso_id).and_return(@course.id)
        Course.should_receive(:find_by_id).and_return(@course)        
        get :show
        response.should be_success
      end
      
    end

    #
    #months
    #
    context "months" do

      it "Deve aceitar o nivel mestrado" do
        @subscription = SubscriptionsController.new
        @subscription.months("Mestrado")
        response.should be_success
      end

      it "Deve aceitar o nivel doutorado" do
        @subscription = SubscriptionsController.new
        @subscription.months("Doutorado")
        response.should be_success
      end

    end
    
    #
    # new
    #

    context "GET new" do
       
      it "A criação de uma nova subscription deve ter sucesso" do
        @subscriptions = mock_subscription
        get :new
        response.should be_success
      end
    end

    #
    # edit
    #
    context "GET edit" do
      it "A edicao de uma subscription deve ter sucesso" do
        @subscription = Subscription.find_by_id(1)
        Subscription.should_receive(:find).and_return(@subscription)
        get :edit
        response.should be_success
      end
    end

    #
    # create
    #
    context "POST create" do

      before :each do
        @course = Course.find_by_id(1)
        Course.should_receive(:find).with(any_args()).and_return(@course)
      end

      it "A criação de um subscription deve ter sucesso" do
        post :create, :subscription => valid_subscription_attributes
        response.should be_success
      end

      it "A criação de uma subscription sem os campos obrigatorios nao deve ter sucesso" do
        post :create, :subscription => invalid_subscription_attributes
        response.should_not be_success
      end

      it "A criação de um subscription deve ter sucesso com reference_teacher" do
        post :create, :subscription => valid_subscription_attributes, :reference_teachers => mock_reference_teacher
        response.should redirect_to(new_subscription_reference_teacher_url(@user.subscriptions.last))
      end

      it "A criação de um subscription deve ter sucesso com create" do
        post :create, :subscription => valid_subscription_attributes, :create => {:name => "create"}
        response.should redirect_to(user_subscriptions_url(@user))
      end

      it "A criação de um subscription deve ter sucesso com end" do
        post :create, :subscription => valid_subscription_attributes, :end => {:name => "end"}
        response.should redirect_to(user_subscriptions_url(@user))
      end

    end

    #
    # update
    #

    context "POST update" do

      it "A atualização de um subscription sem curso não deve ter sucesso" do
        post :update, :id => 1
        response.should_not be_success
      end

      it "A atualização de um subscription sem curso apresentar mensagem de erro" do
        post :update, :id => 1
        flash[:notice].should == "escolha um curso, um programa e uma área."
      end
      
      it "A atualização de um subscription sem curso deve redirecionar para pagina de edição" do
        post :update, :id => 1
        response.should redirect_to(edit_subscription_url)
      end

      context "update com curso" do
        before :each do
          @course = Course.find_by_id(1)
          Course.should_receive(:find).with(any_args()).and_return(@course)
        end

        it "A atualização de um subscription deve ter sucesso" do
          post :update, :id => 1
          response.should be_success
        end

        it "A atualização de um subscription deve ter sucesso com reference_teacher" do
          post :update, :id => 1, :reference_teachers => mock_reference_teacher
          response.should redirect_to(subscription_reference_teachers_url(@user.subscriptions.find_by_id(1)))
        end

        it "A atualização de um subscription deve ter sucesso com update" do
          post :update, :id => 1, :subscription => valid_subscription_attributes, :update => {:name => "update"}
          response.should redirect_to(user_subscriptions_url(@user))
        end

        it "A atualização de um subscription deve ter sucesso com end" do
          post :update, :id => 1, :subscription => valid_subscription_attributes, :end => {:name => "end"}
          response.should redirect_to(user_subscriptions_url(@user))
        end
      end

      context "Update com curso e parametros incorretos" do
        before :each do
          @course = Course.find_by_id(8)
          Course.should_receive(:find).with(any_args()).and_return(@course)
          Course.should_receive(:first).and_return(@course)
          Course.should_receive(:find).with(:all, :group => 'area').and_return(@course.area)
          Course.should_receive(:find).with(:all, :conditions => { :area => @course.area }, :group => 'subarea').and_return(@course.subarea)
        end

        it "A atualização de um subscription com parametros incorretos não deve ser aceito" do
          post :update, :id => 2, :subscription => invalid_subscription_attributes
          response.should_not be_success
        end
        
        it "A atualização de um subscription com parametros incorretos não deve ser aceito e deve redirecionar" do
          post :update, :id => 2, :subscription => invalid_subscription_attributes
          response.should redirect_to(edit_subscription_url)
        end
      
      end
    end

    #
    #destroy
    #
    context "DELETE destroy" do
      
      it "Deve apagar uma subscription com sucesso" do
        delete :destroy, :user_id => @user.id, :id => 1
        response.should_not be_success
      end
      
    end

  end

  context "WHEN USER IS NOT LOGGED IN" do

    context "GET new" do

      it "A criaçao de uma nova subscription não deve ter sucesso" do
        @subscriptions = mock_subscription
        get :new
        response.should_not be_success
      end

      it "Deve ser redirecionado para pagina de login" do
        @subscriptions = mock_subscription
        get :new
        response.should redirect_to(root_url)
      end
    end

    context "GET edit" do

      it "A edicao de uma subscription não deve ter sucesso" do
        get :edit
        response.should_not be_success
      end

      it "Deve ser redirecionado para pagina de login" do
        get :edit
        response.should redirect_to(root_url)
      end
    end

    context "POST create" do

      it "Deve aparecer seguinte mensagem de erro" do
        post :create
        flash[:notice].should == "É necessário estar logado para criar uma nova inscrição."
      end

      it "Deve ser redirecionado para pagina de login" do
        post :create
        response.should redirect_to(root_url)
      end
    end
    
    #
    # update
    #
    
    context "POST update" do

      it "Deve aparecer seguinte mensagem de erro" do
        post :update
        flash[:notice].should == "É necessário estar logado para atualizar uma inscrição."
      end

      it "Deve ser redirecionado para pagina de login" do
        post :update
        response.should redirect_to(root_url)
      end
    end



  end

  #Delete this example and add some real ones
  it "should use SubscriptionsController" do
    controller.should be_an_instance_of(SubscriptionsController)
  end



  it "Deve ser possivel recomendar um único professor" do
    pending
  end

  it "Deve ser possível recomendar dois professores" do
    pending
  end

end
