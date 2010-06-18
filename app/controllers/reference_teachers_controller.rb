class ReferenceTeachersController < ApplicationController
  # GET /reference_teachers
  # GET /reference_teachers.xml
  def index
    @subscription = Subscription.find(params[:subscription_id])
    @subscription_id = params[:subscription_id]
    @reference_teachers = @subscription.reference_teachers
    @user = current_user
  end

  # GET /reference_teachers/1
  # GET /reference_teachers/1.xml
  def show
    @subscription = Subscription.find(params[:subscription_id])
    @reference_teacher = @subscription.reference_teachers.find(params[:id])
  end

  # GET /reference_teachers/new
  # GET /reference_teachers/new.xml
  def new
    @subscription = Subscription.find(params[:subscription_id])
    @reference_teacher = @subscription.reference_teachers.build
  end

  # GET /reference_teachers/1/edit
  def edit
    @subscription = Subscription.find(params[:subscription_id])
    @reference_teacher = @subscription.reference_teachers.find(params[:id])
  end

  # POST /reference_teachers
  # POST /reference_teachers.xml
  def create
    @subscription = Subscription.find(params[:subscription_id])
    @reference_teacher = @subscription.reference_teachers.build(params[:reference_teacher])
    #salva o professor que recomendará
    if @reference_teacher.save
      #usa o id do professor salvo para gerar o hash para proteção do link de submissão da carta
      @hashcode = Digest::MD5.hexdigest((:reference_teacher_id.to_int + rand(255)).to_s)
      @rt = ReferenceTeacher.find_by_hashcode(@hashcode)
      while(@rt != nil) #verifica se o hash não é existente já (ok, muito improvável...mas não queremos que o sistema quebre) para outro professor
        @hashcode = Digest::MD5.hexdigest((:reference_teacher_id.to_int + rand(255)).to_s)
        @rt = ReferenceTeacher.find_by_hashcode(@hashcode)
        ReferenceTeacher.find_by_hashcode(@hash)
      end
      #atribui o código de hash ao professor salvo
      @reference_teacher.hashcode = @hashcode
      @reference_teacher.save
      redirect_to subscription_reference_teachers_url(@subscription)
    else
      render :action => "new"
    end
  end

  def send_mail
    @destination = params[:email]
    @teacher = params[:teacher]
    @student = params[:student]
    @subscription = params[:subscription]
    @language =  params[:language]
    @hashcode = params[:hashcode]
    if @language == "Português"
      if Notifier.deliver_notification(@destination,@teacher,@student,@hashcode)
        @message = "Sucesso no envio! UUUUbaaaaaa!"
      else
        @message = "Falha no Envio... :("
      end
    else if @language == "Inglês"
        if Notifier.deliver_notificationenglish(@destination,@teacher,@student,@hashcode)
          @message = "Sucesso no envio! UUUUbaaaaaa!"
        else
          @message = "Falha no Envio... :("
        end
      end
    end
    render :mail_result
  end

  # PUT /reference_teachers/1
  # PUT /reference_teachers/1.xml
  def update

    @subscription = Subscription.find(params[:subscription_id])
    @reference_teacher = @subscription.reference_teachers.find(params[:id])

    if @reference_teacher.update_attributes(params[:reference_teacher])
      redirect_to subscription_reference_teachers_url(@subscription)
    else
      render :action => "edit"
    end
  end

  # DELETE /reference_teachers/1
  # DELETE /reference_teachers/1.xml
  def destroy
    @subscription = Subscription.find(params[:subscription_id])
    @reference_teacher = @subscription.reference_teachers.find(params[:id])
    @reference_teacher.destroy
    
    respond_to do |format|
      format.html { redirect_to(subscription_reference_teachers_url(@subscription)) }
      format.xml  { head :ok }
    end
  end

  def process_letter
    @hash = params[:id]
    @teacher = ReferenceTeacher.find_by_hashcode(@hash)
    if !@teacher.nil?
      @teacher_id =  @teacher.id
      @subscription_id = @teacher.subscription_id
      @subscription = Subscription.find_by_id(@subscription_id)
      @user = @subscription.user_id
      render :inline => "Hash encontrado!<br/>Usuário: "+@user.to_s+"<br/>Inscrição: "+@subscription_id.to_s+"<br/>Professor: "+@teacher_id.to_s
    else
      render :inline => "Url não encontrada!"
    end
  end

end
