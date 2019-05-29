class ProjectsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @projects = Project.all.includes(:customer).order('created_at DESC').page(params[:page])
    @customers = Customer.where('name LIKE?', "%#{params[:customer]}%") if params[:customer].present?
    @projects = @projects.where(customer_id: @customers.pluck(:id)) if @customers
    @projects = @projects.where('name LIKE?', "%#{params[:project]}%") if params[:project].present?
  end
  
  def show
    @project = Project.find(params[:id])
    
    @orders = @project.orders.order('status, out_date, out_time, in_date, in_time').page(params[:page])
    @orders = @orders.where(status: params[:status]) if params[:status].present?
    @orders = @orders.where('out_date LIKE?', "%#{params[:out_date]}%") if params[:out_date].present?
    @orders = @orders.where('in_date LIKE?', "%#{params[:in_date]}%") if params[:in_date].present?
  end
  
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    
    if @project.save
      flash[:success] = '現場を登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '現場の登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    
    if @project.update(project_params)
      flash[:success] = '現場の編集が完了しました。'
      redirect_to @project
    else
      flash.now[:danger] = '現場の編集に失敗しました。'
      render :edit
    end
  end
  
  private
  
  def project_params
    params.require(:project).permit(:customer_id, :name, :address)
  end
end
