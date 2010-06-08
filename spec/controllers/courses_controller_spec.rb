require 'spec_helper'

describe CoursesController do

  def mock_course()
    @mock_course ||= mock_model(Course)
  end

  def valid_course_attributes(attributes={})
    {
      :area => 'Ciencias da computacao',
      :subarea => 'banco de dados',
      :nivel => 'mestrado',
    }.merge attributes
  end

  def invalid_course_attributes(attributes={})
    {
      :area => '',
      :subarea => 'banco de dados',
      :nivel => 'mestrado',
    }.merge attributes
  end

  context "GET show" do
    #@course = Course.find(params[:id])
    before :each do
      @course = mock_course
      Course.should_receive(:find).and_return(@course)
      get :show
    end

    it "deveria mostrar os cursos" do
     response.should be_success
   end
  end

  context "GET new" do
    before :each do
      @course = mock_course
      Course.should_receive(:new).and_return(@course)
      get :new
    end

    it "Criacao do novo curso deveria ser sucesso" do
       response.should be_success
    end
  end

  context "GET edit" do
    #@course = Course.find(params[:id])
    before :each do
      @course = mock_course
      Course.should_receive(:find).and_return(@course)
      get :edit, :id =>@course.id
    end

    it "Edicao de um curso deveria ser sucesso" do
       response.should be_success
    end
  end


  context "Quando o controller recebe POST create..." do
    before :each do
      @course = mock_course
      Course.should_receive(:new).once.and_return(@course)
    end

    context "...para um curso válido..." do
      before :each do
        @attributes = valid_course_attributes
        @course.should_receive(:save).once.and_return(true)
      end
      it "...deveria redirecionar para a página do novo curso." do
       post :create, @attributes
       response.should redirect_to(course_path(@course))
     end
    end

    context "...para um curso inválido..." do
      before :each do
        @attributes = invalid_course_attributes
        @course.should_receive(:save).once.and_return(false)
      end
      it "...deveria redirecionar para a página de criação de um novo curso." do
        post :create, @attributes
        response.should render_template(:new)
     end
    end
  end


  context "POST update" do
    before :each do
      @course = mock_course
      Course.should_receive(:find).and_return(@course)
    end
    it "Atualizacao de um curso com parâmetros válidos deveria ter sucesso" do
      @update_attributes = valid_course_attributes
      @course.should_receive(:update_attributes).and_return(true)
      post :update
      assigns[:course].should == @course
    end

    it "Atualizacao de um curso com parâmetros inválidos deveria ter sucesso" do
      @update_attributes = invalid_course_attributes
      @course.should_receive(:update_attributes).and_return(false)
      post :update
      response.should render_template(:edit)
    end
  end
end
