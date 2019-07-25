class UsersController < ApplicationController
  # before_action :require_user_logged_in 追々導入する
  
  def index
    @users = User.all.order('name').page(params[:page])
    @users = @users.where('name LIKE?', "%#{params[:name]}%") if params[:name].present?
    @users = @users.where(status: params[:user][:status].to_i) if params[:user].present?
  end
  
  def show
    @user = User.find(params[:id])
    
    @orders = @user.orders.order('status, out_date, out_time, in_date, in_time').page(params[:page])
    @orders = @orders.where(status: params[:order][:status].to_i) if params[:order].present?
    @orders = @orders.where('out_date LIKE?', "%#{params[:out_date]}%") if params[:out_date].present?
    @orders = @orders.where('in_date LIKE?', "%#{params[:in_date]}%") if params[:in_date].present?
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'ユーザの編集が完了しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの編集に失敗しました。'
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :status, :remarks)
  end
end
