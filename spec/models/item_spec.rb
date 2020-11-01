require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '#create' do
    context '商品を出品できる' do
      it '全ての情報が存在すれば出品できる' do
        expect(@item).to be_valid
      end

      it 'priceが半角数字なら出品できる' do
        @item.price = 1111
        expect(@item).to be_valid
      end

      it 'priceが300~9,999,999の間なら出品できる' do
        @item.price = 974_932
        expect(@item).to be_valid
      end

      it 'prefecture_idが1以外なら出品できる' do
        @item.prefecture_id = 2
        expect(@item).to be_valid
      end

      it 'category_idが1以外なら出品できる' do
        @item.category_id = 2
        expect(@item).to be_valid
      end

      it 'condition_idが1以外なら出品できる' do
        @item.condition_id = 2
        expect(@item).to be_valid
      end

      it 'postage_idが1以外なら出品できる' do
        @item.postage_id = 2
        expect(@item).to be_valid
      end

      it 'delivery_day_idが1以外なら出品できる' do
        @item.delivery_day_id = 2
        expect(@item).to be_valid
      end
    end

    context '商品を出品できない' do
      it 'titleが空なら出品できない' do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end

      it 'detailが空なら登録できない' do
        @item.detail = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Detail can't be blank")
      end

      it 'priceが空なら登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが300~9,999,999以外なら登録できない' do
        @item.price = 190
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it 'priceが半角数字以外なら登録できない' do
        @item.price = '１２３５６'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it 'imageが空では出品できない' do
        @item.image = nil
        expect(@item.image.attached?).to eq(false)
      end

      it 'category_idが1なら保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end

      it 'prefecture_idが0なら保存できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 0')
      end

      it 'condition_idが1なら保存できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be other than 1')
      end

      it 'postage_idが1なら保存できない' do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Postage must be other than 1')
      end

      it 'delivery_day_idが1なら保存できない' do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery day must be other than 1')
      end
    end
  end
end
