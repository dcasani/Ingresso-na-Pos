require 'spec_helper'

describe ReferenceTeachersController do

  #Delete this example and add some real ones
  it "should use ReferenceTeacherController" do
    controller.should be_an_instance_of(ReferenceTeachersController)
  end

  it "Deve ser possivel criar um professor recomendante" do
     @reference_teacher = ReferenceTeacher.create(:nome => 'Daniel', :instituicao => 'USP', :email => 'a@a.com.br', :lingua => 'Spanish')
     @reference_teacher.should have(:no).errors
     #continuar esse teste
  end

  it "Deve ser possivel editar um professor um professor recomendante" do
    pending
  end

end
