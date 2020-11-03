FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id {1}
    city  {"大津市"}
    address {"青山1-1"}
    apartment {}
    phone_number {"22222"}
    token {"tok_abcdefghijk00000000000000000"}
  end
end
