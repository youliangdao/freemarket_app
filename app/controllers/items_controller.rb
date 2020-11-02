class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]
  def index
    @items = Item.order(id: 'DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    render action: :new and return unless @item.valid?

    redirect_to root_path
  end

  def show
  end

  def edit
    redirect_to root_path and return unless set_item.order == nil
  end

  def update
    @item.update(item_params)
    render action: :edit and return unless @item.valid?

    redirect_to item_path(@item)
  end

  def destroy
    @item.destroy
    redirect_to root_path
    
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :detail, :category_id,
                                 :condition_id, :postage_id, :prefecture_id, :delivery_day_id, :price)
          .merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    set_item
    redirect_to root_path unless current_user.id == @item.user_id
  end
end
