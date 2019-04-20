class PlacesController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @places = Place.all.page(params[:page])
  end
  
  def show
    @place = Place.find(params[:id])
  end
  
  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    
    if @place.save
      flash[:success] = '現場を登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '現場の登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @place = Place.find(params[:id])
  end
  
  def update
    @place = Place.find(params[:id])
    
    if @place.update(place_params)
      flash[:success] = '現場の編集が完了しました。'
      redirect_to @place
    else
      flash.now[:danger] = '現場の編集に失敗しました。'
      render :edit
    end
  end
  
  private
  
  def place_params
    params.require(:place).permit(:name, :address)
  end
end
