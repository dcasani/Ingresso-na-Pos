require 'spec_helper'

describe SubscriptionsController do
  fixtures :users, :courses

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

   context "when logged in" do
     before {activate_authlogic}

     context "GET new" do

       it "O usuario deve estar logado" do
         pending
        @user = User.find_by_id(1)
        login_as_user :teste
        @user_logged = current_user
        assigns[:user] == @user_logged
       end

       before :each do
         @user = User.find_by_id(1)
         login_as_user :teste
        # @user_session = mock_user_session
        # @user = UserSession.create(mock_user)
         @subscriptions = mock_subscription
         @user.should_receive(:subscriptions).and_return(@subscriptions)
         @subscription = mock_subscription
         @subscriptions.should_receive(:build).and_return(@subscription)
         get :new
       end

       it "A criação de uma nova subscription deve ter sucesso" do
         pending
         response.should be_success
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
