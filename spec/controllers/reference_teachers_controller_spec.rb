require 'spec_helper'

describe ReferenceTeachersController do

  def mock_user()
    @mock_user ||= mock_model(User)
  end

  def mock_subscription()
    @mock_subscription ||= mock_model(Subscription)
  end

  def mock_reference_teacher()
    @mock_reference_teacher ||= mock_model(ReferenceTeacher)
  end

 def valid_reference_teacher_attributes(attributes={})
    {
      :nome => 'Cassia Garcia Ferreira',
      :instituicao => 'USP',
      :email => 'cassia@usp.br',
      :lingua => 'portugues'
    }.merge attributes
  end

 context "GET show" do
   before :each do
     @subscription = mock_subscription
     Subscription.should_receive(:find).and_return(@subscription)
     @reference_teachers = mock_reference_teacher
     @subscription.should_receive(:reference_teachers).and_return(@reference_teachers)
     @reference_teacher = mock_reference_teacher
     @reference_teachers.should_receive(:find).and_return(@reference_teacher)
     get :show
   end

   it "" do
     response.should be_success
   end

   it "should assign new reference_teacher" do
     assigns[:reference_teacher].should == mock_reference_teacher
   end


 end

  context "GET new" do
    before :each do
     @subscription = mock_subscription
     Subscription.should_receive(:find).and_return(@subscription)
     @reference_teachers = mock_reference_teacher
     @subscription.should_receive(:reference_teachers).and_return(@reference_teachers)
     @reference_teacher = mock_reference_teacher
     @reference_teachers.should_receive(:build).and_return(@reference_teacher)
     get :new 
   end

   it "A criação de um novo reference_teacher deve ter sucesso" do
     response.should be_success
   end

   it "should assign new reference_teacher" do
     assigns[:reference_teacher].should == mock_reference_teacher
   end
 end

 context "GET edit" do
   before :each do
     @subscription = mock_subscription
     Subscription.should_receive(:find).and_return(@subscription)
     @reference_teachers = mock_reference_teacher
     @subscription.should_receive(:reference_teachers).and_return(@reference_teachers)
     @reference_teacher = mock_reference_teacher
     @reference_teachers.should_receive(:find).and_return(@reference_teacher)
     get :edit, :id =>@reference_teacher.id
   end

   it "A edição de um reference_teacher deve ter sucesso" do
     response.should be_success
   end

   it "should assign new reference_teacher" do
     assigns[:reference_teacher].should == @reference_teacher
   end

 end

 context "POST create" do
   before :each do
     @subscription = mock_subscription
     Subscription.should_receive(:find).and_return(@subscription)
     @reference_teachers = mock_reference_teacher
     @subscription.should_receive(:reference_teachers).and_return(@reference_teachers)
     @reference_teacher = mock_reference_teacher
     @reference_teachers.should_receive(:build).and_return(@reference_teacher)
     @subscription.should_receive(:save).and_return(true)
     post :create, :reference_teacher => valid_reference_teacher_attributes
   end

   it "A criação de um reference_teacher deve ter sucesso" do
     pending
     response.should be_success
   end

   it "should create a reference_teacher given valid attributes"do
     assigns[:reference_teacher].should == @reference_teacher
   end

   it "reference_teacher não deve ser nulo" do
     @reference_teacher.should_not be_nil
   end
   
 end

 context "POST update" do
  before :each do
    @subscription = mock_subscription
     Subscription.should_receive(:find).and_return(@subscription)
     @reference_teachers = mock_reference_teacher
     @subscription.should_receive(:reference_teachers).and_return(@reference_teachers)
     @reference_teacher = mock_reference_teacher
     @reference_teachers.should_receive(:find).and_return(@reference_teacher)
     @reference_teacher.should_receive(:update_attributes).and_return(true)
     post :update
  end

   it "should update a reference_teacher given valid attributes"do
     assigns[:reference_teacher].should == @reference_teacher
   end
  
 end

 context "DELETE destroy" do
   before :each do
     @subscription = mock_subscription
     Subscription.should_receive(:find).and_return(@subscription)
     @reference_teachers = mock_reference_teacher
     @subscription.should_receive(:reference_teachers).and_return(@reference_teachers)
     @reference_teacher = mock_reference_teacher
     @reference_teachers.should_receive(:find).and_return(@reference_teacher)
     @reference_teacher.should_receive(:destroy)
     delete :destroy, :id => @reference_teacher.id
 end

  it "should delete a reference_teacher "do
    pending
     assigns[:reference_teacher].should be_nil
     response.should redirect_to(subscription_reference_teachers_url(@subscription))
     response.should head(:ok)
   end
 end


  it "Deve ser possivel criar um professor recomendante" do
    #@reference_teacher = ReferenceTeacher.create(:nome => 'Daniel', :instituicao => 'USP', :email => 'a@a.com.br', :lingua => 'Spanish')
    #@reference_teacher.should have(:no).errors
    #continuar esse teste
    pending
  end

  it "Deve ser possivel editar um professor um professor recomendante" do
    pending
  end


  #Delete this example and add some real ones
  it "should use ReferenceTeacherController" do
    controller.should be_an_instance_of(ReferenceTeachersController)
  end

end
