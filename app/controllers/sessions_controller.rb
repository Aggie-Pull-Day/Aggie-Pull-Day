class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]

  def new; end

  def create
    session_params = params.permit(:authenticity_token, :email, :password, :commit)
    student = Student.find_by(email: session_params[:email])
    @user = User.find_by(uid: student[:uid])
    if @user&.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to @user.admin ? '/dashboard' : @user
    else
      flash[:notice] = 'Login is invalid!'
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to articles_path
  end
end
