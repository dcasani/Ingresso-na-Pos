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
      :formacao_superior_graduacao => "Bacharelado em Ciência da Computação",
    }.merge attributes
  end

   def valid_subscription_attributes(attributes={})
     {
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

   context "when logged in" do
     before {activate_authlogic}
     before :each do
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

      it "A criação de um subscription deve ter sucesso" do
       pending
       @subscription = mock_subscription
       @subscription = valid_subscription_attributes
       Subscription.should_receive(:build).and_return(@subscription)
       @course = Course.find_by_id(1)
       Course.should_receive(:find).and_return(@course)
       @course.should_receive(:id).and_return(@course.id)
       @subscription.should_receive(:save).and_return(true)
       post :create
       #response.should redirect_to(new_subscription_reference_teacher_url(@subscription.id))
       response.should render_template(:new)
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
