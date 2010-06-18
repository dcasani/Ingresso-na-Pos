require 'spec_helper'

describe Notifier do
  fixtures :users, :courses, :subscriptions

  def mock_user()
    @mock_user ||= mock_model(User)
  end

  def mock_reference_teacher()
    @mock_reference_teacher ||= mock_model(ReferenceTeacher)
  end

   def valid_reference_teacher_attributes(attributes={})
    {
      :nome => 'Cassia Garcia Ferreira',
      :instituicao => 'USP',
      :email => 'cassia@usp.br',
      :lingua => 'portugues',
      :hashcode => '6c4b761a28b734fe93831e3fb400ce87'
    }.merge attributes
  end
 
  
  context "Notification Portuguese" do

     before :each do
      activate_authlogic
      @user = User.find_by_id(1)
      login_as_user :teste
    end
    
    before(:each) do
    @valid_attributes = {
      :destination => "teste@teste.com.br",
      :teacher => mock_reference_teacher,
      :student => mock_user,
      :hashcode => '6c4b761a28b734fe93831e3fb400ce87'
    }
    @notifier = Notifier.new
  end
    
    it "should create a new instance given valid attributes" do
      Notifier.deliver_notification("teste@teste.com.br", valid_reference_teacher_attributes, User.find_by_id(1), '6c4b761a28b734fe93831e3fb400ce87')
    end

    it "should create a new instance given valid attributes" do
      Notifier.deliver_notificationenglish("teste@teste.com.br", valid_reference_teacher_attributes, User.find_by_id(1), '6c4b761a28b734fe93831e3fb400ce87')
      #response.should be_success
    end
    
  end
end

