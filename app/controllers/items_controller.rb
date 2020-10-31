class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
  end

  def new
    
  end

  def create
    # item = Item.create(item_params)
    # redirect_to new_item_path and return unless item.valid?
    # redirect_to root_path
  end

  # private

  # def item_params
  #   params.require(:item).permit(:image, :title, :detail, :category_id, 
  #                                :condition_id, :postage_id, :prefecture_id, :delivery_id, :price).merge(user_id: current_user.id)
  # end
end
