class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.integer    :postal_code    , null: false
      t.integer    :prefecture_id  , null: false
      t.string     :city           , null: false
      t.string     :address        , null: false
      t.string     :apartment      , default: ""
      t.string     :phone_number   , null: false
      t.references :order          , foreign_key: true
      t.timestamps
    end
  end
end
