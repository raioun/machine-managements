class CompaniesController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @companies = Company.all.order('name').page(params[:page])
    @companies = @companies.where('name LIKE?', "%#{params[:company]}%") if params[:company].present?
  end
  
  def show
    @company = Company.find(params[:id])
    @branches = @company.branches.order('id').page(params[:page])
  end
  
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    
    if @company.save
      flash[:success] = '所有企業を登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '所有企業の登録に失敗しました。'
      render :new
    end
  end
  
  private
  
  def company_params
    params.require(:company).permit(:name)
  end
end
