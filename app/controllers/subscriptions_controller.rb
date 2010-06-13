class SubscriptionsController < ApplicationController
  # GET /subscriptions
  # GET /subscriptions.xml
  def index
    @user = current_user
    @subscriptions = @user.subscriptions
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.xml
  def show
    @user = current_user
    @subscription = @user.subscriptions.find(params[:id])
    @course = Course.find_by_id(@subscription.curso_id)
    @teachers = ReferenceTeacher.find_all_by_subscription_id(@subscription.id)
  end

  def months(nivel)
    @st_months = Array.new
    if nivel == "Mestrado"
      @st_months[0] = "Março"
      @st_months[1] = "Agosto"
    else
      @st_months[0] = "Janeiro"
      @st_months[1] = "Fevereiro"
      @st_months[2] = "Março"
      @st_months[3] = "Abril"
      @st_months[4] = "Maio"
      @st_months[5] = "Junho"
      @st_months[6] = "Julho"
      @st_months[7] = "Agosto"
      @st_months[8] = "Setembro"
      @st_months[9] = "Outubro"
      @st_months[10] = "Novembro"
      @st_months[11] = "Dezembro"
    end
    return @st_months
  end

  # GET /subscriptions/new
  # GET /subscriptions/new.xml
  def new
    @user = current_user
    #verificar se existe session
    if @user != nil
      @subscription = @user.subscriptions.build
      @course_areas = Course.find(:all, :group => 'area')
      #@course = Course.find_by_id(@subscription.curso_id)
      @course = Course.first
      @course_subareas = Course.find(:all, :conditions => { :area => @course.area }, :group => 'subarea' )
      @st_months = months("Mestrado")
      @month_selected = ""
    else
      redirect_to root_url
    end

  end

  def course_subareas
    @area = params[:area].sub("area_select=","")
    @render = ""
    @subareas = Course.find(:all, :conditions => { :area => @area}, :group => 'subarea' )
    @subareas.each do |course|
      @render += "<option>"+course.subarea+"</option>"
    end
    render :inline => "<%= @render %>"

  end

  def starting_months
    @nivel = params[:nivel].sub("nivel_select=","")
    @render = ""
    if @nivel == "Doutorado"
      @render += "<option>Janeiro</option><option>Fevereiro</option><option>Março</option><option>Abril</option><option>Maio</option><option>Junho</option><option>Julho</option><option>Agosto</option><option>Setembro</option><option>Outubro</option><option>Novembro</option><option>Dezembro</option>"
    else
      @render += "<option>Março</option><option>Agosto</option>"
    end
    render :inline => "<%= @render %>"
  end

  # GET /subscriptions/1/edit
  def edit
    @user = current_user
    if @user != nil
      @subscription = @user.subscriptions.find(params[:id])
      @course_areas = Course.find(:all, :group => 'area')
      @course = Course.find_by_id(@subscription.curso_id)
      @area_selected = @course.area
      @nivel_selected = @course.nivel
      @subarea_selected = @course.subarea
      @course_subareas = Course.find(:all, :conditions => { :area => @course.area }, :group => 'subarea' )
      @st_months = months(@nivel_selected)
      @month_selected = @subscription.inicio_pretendido
    else
      redirect_to root_url
    end
  end

  #
  # POST Create
  #
  def create
    # Verifica se há um usuário logado
    if(!current_user)
      flash[:notice] = "É necessário estar logado para criar uma nova inscrição."
      redirect_to root_url

      # Usuário logado
    else

      @user = current_user

      # Gera nova inscrição
      @subscription = @user.subscriptions.build(params[:subscription])

      # identifica o curso selecionado
      @course = Course.find(:first, :conditions => {:nivel => params[:nivel_select],
          :area => params[:area_select], :subarea => params[:subarea_select]})

      @saved = false

      # se o curso não está no banco, volte para a tela de criação
      if(@course)

        # associe a inscrição ao curso
        @subscription.curso_id = @course.id

        # Salve a inscrição
        if @subscription.save
          @saved = true
          redirect_to new_subscription_reference_teacher_path(@subscription)
        end
      end

      # Se a inscrição não foi salva, volte á tela de criação
      if !@saved
        flash[:notice] = "Ocorreu um erro ao tentar salvar sua inscrição. Por favor tente novamente."
        redirect_to new_subscription_url
      end
    end
  end

  #
  # POST Update
  #
  def update
    # Verifica se há um usuário logado
    if(!current_user)
      flash[:notice] = "É necessário estar logado para atualizar uma inscrição."
      redirect_to root_url

      # Usuário logado
    else

      @user = current_user

      # Localiza a inscrição
      @subscription = @user.subscriptions.find(params[:id])

      # Localiza o curso
      @course = Course.find(:first, :conditions => {:nivel => params[:nivel_select],
          :area => params[:area_select], :subarea => params[:subarea_select]})

      # Se o curso não está no banco
      if(!@course)
        flash[:notice] = "escolha um curso, um programa e uma área."
        redirect_to edit_subscription_url

        # curso registrado
      else

        # Associe o curso à inscrição
        @subscription.curso_id = @course.id

        # Atualize os dados da inscrição
        if @subscription.update_attributes(params[:subscription])
          redirect_to user_subscriptions_url(current_user)
          # Se a atulização não for bem sucedida, volte à tela de edição
        else
          @course_areas = Course.find(:all, :group => 'area')
          @course = Course.first;
          @course_subareas = Course.find(:all, :conditions => { :area => @course.area }, :group => 'subarea' )
          @month_selected = params[:subscription_inicio_pretendido]
          @st_months = months(@course.nivel)
          redirect_to edit_subscription_url
        end
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.xml
  def destroy
    @user = User.find(params[:user_id])
    @subscription = @user.subscriptions.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to(user_subscriptions_url(@user)) }
      format.xml  { head :ok }
    end
  end

end


