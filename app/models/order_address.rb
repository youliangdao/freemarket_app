class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :apartment, :phone_number

  with_options presence: true do
    validates :postal_code, format: {with: }
    validates :city
    validates :address, format: {with: /\A\d{3}[-]\d{4}\z/}
    validates :phone_number, /\A\d{1,10}\z
  end

  validates :prefecture_id, numericality: {other_than: 0}

  def save
    item = Item.find(params[:id])
    user = item.user
    order = Order.create(user_id: user.id, item_id: item.id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, apartment: apartment, phone_number: phone_number, order_id: item.order_id)
  end
end