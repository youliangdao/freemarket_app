class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :move_to_index, only: [:index]
  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render action: :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :address, :apartment, :phone_number)
          .merge(item_id: params[:item_id], token: params[:card_token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    item = Item.find(order_params[:item_id])
    Payjp::Charge.create(
      amount: item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == item.user_id || item.order != nil
  end
end
