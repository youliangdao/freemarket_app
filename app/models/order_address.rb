class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :apartment, :phone_number, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :city
    validates :address
    validates :token
    validates :phone_number, format: { with: /\A\d{1,11}\z/ }
  end

  validates :prefecture_id, numericality: { other_than: 0 }

  def save
    item = Item.find(item_id)
    user = item.user
    order = Order.create(user_id: user.id, item_id: item_id, token: token)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city,
                   address: address, apartment: apartment, phone_number: phone_number, order_id: order.id)
  end
end
