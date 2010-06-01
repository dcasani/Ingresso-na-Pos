class UsersController < ApplicationController
  # GET /users
  # GET /users.xml

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end


  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    #utiliza email como login
    @user.username = @user.email
    if @user.save
      flash[:notice] = 'Usuário criado com sucesso!'
      redirect_to new_subscription_url
    else
      flash[:error] = "Usuário não criado."
      render :new
    end
  end
  
  def update
    @user = current_user

    respond_to do |format|
      #utiliza email como login
      @user.username = @user.email
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Usuário alterado com sucesso!'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
