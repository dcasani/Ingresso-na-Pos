class ReferenceTeachersController < ApplicationController
  # GET /reference_teachers
  # GET /reference_teachers.xml
  def index
    @subscription = Subscription.find(params[:subscription_id])
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
    if @subscription.save
      redirect_to subscription_reference_teachers_url(@subscription)
    else
      render :action => "new"
    end
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
      format.html { redirect_to(subscription_reference_teachers_url) }
      format.xml  { head :ok }
    end
  end
end
