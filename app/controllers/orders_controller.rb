class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:id])
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.create(order_address)
    render action: :index and return unless @order_params.valid?

    redirect_to action: :root_path
  end

  private
  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :address, :apartment, :phone_number)
  end
end
