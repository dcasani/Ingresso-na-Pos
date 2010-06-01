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

  context "GET new" do
   # before :each do
   #  @reference_teacher = mock_reference_teacher
   #  ReferenceTeacher.stub!(:new).and_return(@reference_teacher)
   #  @subscription = mock_subscription
   #  Subscription.should_receive(:find).and_return(@subscription)
   #  @subscription.should_receive(:reference_teachers).and_return(@subscription.reference_teachers)
   #  @reference_teacher = valid_reference_teacher_attributes
   #  @subscription.should_receive(:build).and_return(@reference_teacher)
     #@controller.instance_variable_set(:@subscription, @subscription)
    # @reference_teacher = valid_reference_teacher_attributes
   #  get :new,  :subscription_id => @subscription.id
  # end

   it "A criação de um novo reference_teacher deve ter sucesso" do
     pending
     #response.should be_success
     
   end

   #it "should assign new reference_teacher" do
   #  assigns[:reference_teacher].should == mock_reference_teacher
   #end

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
