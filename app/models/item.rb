class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :purchase
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :delivery_day

  with_options presence: true do
  validates :title 
  validates :detail
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }, format: {with: /\A[0-9]+\z/}
  validates :prefecture_id, numericality: { other_than: 1 }
  validates :category_id, numericality: { other_than: 1 }
  validates :condition_id, numericality: { other_than: 1 }
  validates :postage_id, numericality: { other_than: 1 }
  validates :delivery_day_id, numericality: { other_than: 1 }
  end
end
