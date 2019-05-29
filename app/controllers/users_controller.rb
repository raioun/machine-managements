class UsersController < ApplicationController
  # before_action :require_user_logged_in 追々導入する
  
  def index
    @users = User.all.order('name').page(params[:page])
    @users = @users.where('name LIKE?', "%#{params[:user]}%") if params[:user].present?
  end
  
  def show
    @user = User.find(params[:id])
    
    @orders = @user.orders.order('status, out_date, out_time, in_date, in_time').page(params[:page])
    @orders = @orders.where(status: params[:status]) if params[:status].present?
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
  
  private
  
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
