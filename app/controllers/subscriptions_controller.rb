class SubscriptionsController < ApplicationController
  # GET /subscriptions
  # GET /subscriptions.xml
  def index
    @user = User.find(params[:user_id])
    @subscriptions = @user.subscriptions
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.xml
  def show
     @user = User.find(params[:user_id])
     @subscription = @user.subscriptions.find(params[:id])
  end

  # GET /subscriptions/new
  # GET /subscriptions/new.xml
  def new
    @user = User.find(params[:user_id])
    @subscription = @user.subscriptions.build

  end

  # GET /subscriptions/1/edit
  def edit
    @user = User.find(params[:user_id])
    @subscription = @user.subscriptions.find(params[:id])
  end

  # POST /subscriptions
  # POST /subscriptions.xml
  def create
    @user = User.find(params[:user_id])
    @subscription = @user.subscriptions.build(params[:subscription])
    if @subscription.save
      redirect_to user_subscription_url(@user, @subscription)
    else
      render :action => "new"  
    end
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.xml
  def update
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        flash[:notice] = 'Subscription was successfully updated.'
        format.html { redirect_to(@subscription) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subscription.errors, :status => :unprocessable_entity }
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
