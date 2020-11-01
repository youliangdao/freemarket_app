class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
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

  private

  def item_params
    params.require(:item).permit(:image, :title, :detail, :category_id,
                                 :condition_id, :postage_id, :prefecture_id, :delivery_day_id, :price)
          .merge(user_id: current_user.id)
  end
end
