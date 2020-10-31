require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#create" do
    before do
      @user = FactoryBot.build(:user)
    end  

    context "新規登録がうまくいく時" do
      it "全ての項目が存在すれば登録できる" do
       expect(@user).to be_valid
        
      end

      it "emailが@マークがあれば、登録できる" do
        @user.email = "sample@sample.com"
        expect(@user).to be_valid
      end

      it "passwordが６文字以上であれば、登録できる" do
        @user.password = "sample0000"
        @user.password_confirmation = "sample0000"
        expect(@user).to be_valid
      end

      it "同じemailでなければ、登録できる" do
        @user.email = "testtest@test.com"
        @user.save
        user_sample = FactoryBot.build(:user)
        user_sample.email = "testtest1@test.com"
        expect(user_sample). to be_valid
      end

      it "passwordが半角英数字混合であれば、登録できる" do
        password = "abcd123"
        @user.password =  password
        @user.password_confirmation = password
        expect(@user).to be_valid
      end

      it "first_nameとlast_nameが全角（漢字・カタカナ・平仮名）であれば。登録できる" do
        @user.first_name = "漢字ひらがなカタカナ"
        @user.last_name = "漢字漢字ひらがなカタカナ"
        expect(@user).to be_valid

      end

      it "first_name_kanaとlast_name_kanaが全角（カタカナ）であれば、登録できる" do
        @user.first_name_kana = "カタカナ"
        @user.last_name_kana = "カタカナ"
        expect(@user).to be_valid
      end
    end
    
    context "新規登録がうまくいかない時" do
      it "nicknameが空だと登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank") 
      end

      it "emailが空だと登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "emailに@マークが含まれていないと登録できない" do
        @user.email = "samplesample.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "emailが重複していると登録できない" do
        @user.save
        user_sample = FactoryBot.build(:user)
        user_sample.email = @user.email
        user_sample.valid?
        expect(user_sample.errors.full_messages).to include("Email has already been taken")
      end

      it "passwordが空だと登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")  
      end

      it "passwordが5文字以下だと登録できない" do
        @user.password = "luck"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")  
      end

      it "passwordとpassword_confirmationが一致していなければ登録できない" do
        @user.password = "aiueo1234"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")   
      end

      it "passwordが半角でなければ登録できない" do
        @user.password = "１２４９８４wtkb"
        @user.valid?
        expect(@user.errors.full_messages).to include( "Password is invalid")
      end

      it "数字が入っていなければ登録できない" do
        @user.password = "luckekh" 
        @user.valid?
        expect(@user.errors.full_messages).to include( "Password is invalid") 
      end

      it "数字は入っているが、英語が入っていなければ登録できない" do
        @user.password = "1234553"
        @user.valid?
        expect(@user.errors.full_messages).to include( "Password is invalid")
      end

      it "first_nameが空だと登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")  
      end

      it "first_nameが全角でなければ、保存できない" do
        @user.first_name = "aioert"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")  
      end

      it "first_nameが全角だが、英語や記号が含まれていると保存できない" do
        @user.first_name = "会い終えおk３５"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")  
      end


      it "last_nameが全角だが、英語や記号が含まれていると保存できない" do
        @user.last_name = "会い終えおk３５"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end

      it "last_nameが空だと登録できない" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")  
      end

      it "last_nameが全角でなければ、保存できない" do
        @user.last_name = "aioert"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")  
      end

      it "first_name_kanaが空だと登録できない" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")  
      end

      it "first_name_kanaが全角でなければ、保存できない" do
        @user.first_name_kana = "aioert"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")  
      end
      
      it "first_name_kanaにカタカナ以外が含まれているならば保存できない" do
        @user.first_name_kana = "会い終えおk３５"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")  
      end

      it "last_name_kanaが空だと登録できない" do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")  
      end

      it "last_name_kanaが全角でなければ、保存できない" do
        @user.last_name_kana = "aioert"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")  
      end
      
      it "last_name_kanaにカタカナ以外が含まれているならば保存できない" do
        @user.last_name_kana = "会い終えおk３５"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")  
      end

      it "生年月日が空だと登録できない" do
        @user.birth_date = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
