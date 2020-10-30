FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password = Faker::Lorem.characters(number: 10)
    password {password}
    password_confirmation {password}
    birth_date {Faker::Date.between(from: '1930-01-01', to: '2015-12-31')}
    
    first_name {person.first.kanji}
    last_name {person.last.kanji}
    first_name_kana {person.first.katakana}
    last_name_kana {person.last.katakana}

  end
end