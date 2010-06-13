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
      :dados_carta_recomendacao => 'lala' ,
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

   context "when logged in" do
     before :each do
       activate_authlogic
       @user = User.find_by_id(1)
       login_as_user :teste
     end

     context "GET new" do
      
       
       it "A criação de uma nova subscription deve ter sucesso" do
         @subscriptions = mock_subscription
         get :new
         response.should be_success
       end
     end

     context "GET edit" do
       it "A edicao de uma subscription deve ter sucesso" do
         @subscription = Subscription.find_by_id(1)
         Subscription.should_receive(:find).and_return(@subscription)
         get :edit
         response.should be_success
       end
     end

     context "POST create" do

      before :each do
        @subscriptions = mock_subscription
        @course = Course.find_by_id(1)
        Course.should_receive(:find).with(any_args()).and_return(@course)
        #Subscription.should_receive(:build).and_return(@subscriptions)
        #@subscription = mock_subscription
      end

      it "A criação de um subscription deve ter sucesso" do
        pending
        @subscription = valid_subscription_attributes
        Subscription.should_receive(:build).and_return(@subscription)
        @subscription.should_receive(:save).and_return(true)
        post :create
        response.should redirect_to(new_subscription_reference_teacher_path(@subscription))
      end

      it "A criação de uma subscription sem os campos obrigatorios nao deve ter sucesso" do
      pending
      end

     end

   end

     context "when user is not logged in" do

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
         @subscription = Subscription.find_by_id(1)
         get :edit
         response.should_not be_success
       end

      it "Deve ser redirecionado para pagina de login" do
        get :edit
        response.should redirect_to(root_url)
      end
    end

    context "POST create" do
      it "Deve ser redirecionado para pagina de login" do
        post :create
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
