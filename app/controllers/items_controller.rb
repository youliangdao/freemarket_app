class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid? && @item.image.attached?
      redirect_to root_path
    else
      render action: :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :detail, :category_id,
                                 :condition_id, :postage_id, :prefecture_id, :delivery_day_id, :price)
          .merge(user_id: current_user.id)
  end
end
