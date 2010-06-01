require 'spec_helper'

describe ReferenceTeacher do
  before(:each) do
    @valid_attributes = {
      :nome => 'Cassia Garcia Ferreira',
      :instituicao => 'USP',
      :email => 'cassia@usp.br',
      :lingua => 'portugues'
    }
  end

  it "should create a new instance given valid attributes" do
    ReferenceTeacher.create!(@valid_attributes)
  end

  context "Validações de nome:" do

    it "Não deve aceitar nome vazio" do
      @reference_teacher = ReferenceTeacher.new(:nome => '')
      @reference_teacher.should have_at_least(1).errors_on(:nome)
    end

     it "Deve validar um nome real" do
      @reference_teacher = ReferenceTeacher.new(:nome => 'George Daniel Casani Delgado')
      @reference_teacher.should have(:no).errors_on(:nome)
    end

    it "Deve validar um nome com acentos e caracteres latinos" do
      @reference_teacher = ReferenceTeacher.new(:nome => 'Álvaro Cássia João Cauê Cabëçada')
      @reference_teacher.should have(:no).errors_on(:nome)
    end

    it "Não deve validar um nome abreviado" do
      @reference_teacher = ReferenceTeacher.new(:nome => 'George D. C. Delgado')
      @reference_teacher.should have_at_least(1).errors_on(:nome)
    end

    it "Não deve validar um nome com presença de números" do
      @reference_teacher = ReferenceTeacher.new(:nome => 'George2Daniel')
      @reference_teacher.should have(1).errors_on(:nome)
    end

    it "Não deve validar um nome com caracteres estranhos" do
      @reference_teacher = ReferenceTeacher.new(:nome => '!@#$%^&*()-+\|=-~`[]{}')
      @reference_teacher.should have(1).errors_on(:nome)
    end
    

  end

  context "Validações da instituicao:" do
    it "Não deve aceitar instituicao vazia" do
      @reference_teacher = ReferenceTeacher.new(:instituicao => '')
      @reference_teacher.should have_at_least(1).errors_on(:instituicao)
    end
  end

  context "Validações do email:" do
    it "Não deve aceitar email vazio" do
      @reference_teacher = ReferenceTeacher.new(:email => '')
      @reference_teacher.should have_at_least(1).errors_on(:email)
    end
    
    it "Validacoes formato do email" do
      @reference_teacher = ReferenceTeacher.new(:email => 'abc')
      @reference_teacher.should have_at_least(1).errors_on(:email)
      
      @reference_teacher = ReferenceTeacher.new(:email => 'abc@abc')
      @reference_teacher.should have_at_least(1).errors_on(:email)
      
      @reference_teacher = ReferenceTeacher.new(:email => 'abc@abc.com')
      @reference_teacher.should have(:no).errors_on(:email)

    end
  end

  context "Validações da lingua:" do
    it "Não deve aceitar lingua referente ao professor vazia" do
      @reference_teacher = ReferenceTeacher.new(:lingua => '')
      @reference_teacher.should have_at_least(1).errors_on(:lingua)
    end
  end

end
