class UserSessionsController < ApplicationController

  # GET /user_sessions/new
  # GET /user_sessions/new.xml
  def new
    @user_session = UserSession.new
  end

  # POST /user_sessions
  # POST /user_sessions.xml
  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save
      flash[:notice] = 'Usuário logado com sucesso!'
      redirect_to(user_subscriptions_url(current_user))
      #redirect_to user_path(@user_session.user.login) Mezuro
    else
      flash[:message] = "Usuário e/ou senha inválidos!"
      render :action => "new"
    end
  end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.xml
  def destroy
    @user_session = UserSession.find
    @user_session.destroy

    flash[:notice] = "Sessão finalizada com sucesso."
    redirect_to root_url
  end
end
