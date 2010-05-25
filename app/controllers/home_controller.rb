class HomeController < ApplicationController

  def index
    if !current_user
      @user_session = UserSession.new
    end
  end

end

