class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:account, :profile, :edit, :update, :destroy]}
  before_action :forbid_login_user, {only: [:login, :new, :create]}

  def login_form

  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインに成功しました"
      redirect_to controller: :home, action: :top
    else
      @email = params[:email]
      @password = params[:password_digest]
      flash.now[:danger] = "ログインに失敗しました"
      render "users/login_form"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "ログアウトに成功しました"
    redirect_to("/")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation, :image))
    @user.image.attach(io: File.open(Rails.root.join("app/assets/images/default.jpg")), filename: "default.jpg")
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "登録に成功しました"
      redirect_to controller: :users, action: :account, id: @user.id
    else
      @name = @user.name
      @email = @user.email
      flash.now[:danger] = "登録に失敗しました"
      render "new"
    end
  end

  def index
    @users = User.all
  end

  def account
    @user = User.find_by(id: session[:user_id])
  end

  def profile
    @user = User.find_by(id: session[:user_id])
  end

  def edit
    @user = User.find_by(id: session[:user_id])
  end

  def update
    @user = User.find_by(id: session[:user_id])
    if @user && @user.authenticate(params[:user][:current_password])
      if @user.update(params.require(:user).permit(:image, :email, :password, :password_confirmation))
        flash[:success] = "正常に更新されました"
        redirect_to controller: :home, action: :top
      else
        flash.now[:danger] = "入力にエラーがあります"
        render template: "users/edit"
      end
    else
      flash.now[:danger] = "パスワードが間違っています"
      render template: "users/edit"
    end
  end

  def profile_update
    @user = User.find_by(id: session[:user_id])
    if @user.update(params.require(:user).permit(:image, :name, :email, :introduction))
      flash[:success] = "正常に更新されました"
      redirect_to controller: :home, action: :top
    else
      flash.now[:danger] = "入力にエラーがあります"
      render template: "users/profile"
    end
  end

  def destroy

  end
end
