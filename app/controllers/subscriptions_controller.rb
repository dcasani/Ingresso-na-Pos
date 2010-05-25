class SubscriptionsController < ApplicationController
  # GET /subscriptions
  # GET /subscriptions.xml
  def index
    @user = User.find(params[:user_id])
    @subscriptions = @user.subscriptions
    @courses = Array.new
    @subscriptions.each do |subscription|
      @course = Course.find_by_id(subscription.curso_id)
      @courses.add(@course)
    end
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.xml
  def show
    @user = User.find(params[:user_id])
    @subscription = @user.subscriptions.find(params[:id])
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
    @user = User.find(params[:user_id])
    @subscription = @user.subscriptions.build
    @course_areas = Course.find(:all, :group => 'area')
    @course = Course.find_by_id(@subscription.curso_id)
    @course = Course.first
    @course_subareas = Course.find(:all, :conditions => { :area => @course.area }, :group => 'subarea' )
    @st_months = months("Mestrado")
    @month_selected = ""
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
    @user = User.find(params[:user_id])
    @subscription = @user.subscriptions.find(params[:id])
    @course_areas = Course.find(:all, :group => 'area')
    @course = Course.find_by_id(@subscription.curso_id)
    @area_selected = @course.area
    @nivel_selected = @course.nivel
    @subarea_selected = @course.subarea
    @course_subareas = Course.find(:all, :conditions => { :area => @course.area }, :group => 'subarea' )
    @st_months = months(@nivel_selected)
    @month_selected = @subscription.inicio_pretendido
  end

  # POST /subscriptions
  # POST /subscriptions.xml
  def create
    @user = User.find(params[:user_id])
    @subscription = @user.subscriptions.build(params[:subscription])
    @course = Course.find(:first, :conditions => {:nivel => params[:nivel_select],
        :area => params[:area_select], :subarea => params[:subarea_select]})
    @subscription.curso_id = @course.id
    if @subscription.save
      @reference_teacher1 = @subscription.reference_teachers.build(params[:reference_teacher1])
      @reference_teacher1.save
      @reference_teacher2 = @subscription.reference_teachers.build(params[:reference_teacher2])
      @reference_teacher2.save
      redirect_to user_subscription_url(@user, @subscription)
    else
      @course_areas = Course.find(:all, :group => 'area')
      @course = Course.find_by_id(@subscription.curso_id)
      @area_selected = @course.area
      @nivel_selected = @course.nivel
      @subarea_selected = @course.subarea
      @course_subareas = Course.find(:all, :conditions => { :area => @course.area }, :group => 'subarea' )
      @month_selected = params[:subscription_inicio_pretendido]
      @st_months = months(@course.nivel)
      render :action => "new"
    end
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.xml
  def update
    @user = User.find(params[:user_id])
    @subscription = @user.subscriptions.find(params[:id])
    @course = Course.find(:first, :conditions => {:nivel => params[:nivel_select],
        :area => params[:area_select], :subarea => params[:subarea_select]})
    @subscription.curso_id = @course.id
    if @subscription.update_attributes(params[:subscription])
      redirect_to user_subscription_url(@user, @subscription)
    else
      @course_areas = Course.find(:all, :group => 'area')
      @course = Course.first;
      @course_subareas = Course.find(:all, :conditions => { :area => @course.area }, :group => 'subarea' )
      @month_selected = params[:subscription_inicio_pretendido]
      @st_months = months(@course.nivel)
      render :action => "new"
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


