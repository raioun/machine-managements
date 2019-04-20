class CustomersController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    
    if @customer.save
      flash[:success] = '顧客を登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '顧客の登録に失敗しました。'
      render :new
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:name)
  end
end
