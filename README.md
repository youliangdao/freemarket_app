# テーブル設計

## users テーブル

| Column    | Type         | Options                        | 
| --------  | ------------ | ------------------------------ |
| nickname  | string       | null: false                    |
| email     | string       | null: false                    |
| password  | string       | null: false                    |   
| birth_date| date         | null: false                    |   
| item      | references   | null: false, foreign_key: true | 
| purchase  | references   | null: false, foreign_key: true | 
| private   | references   | null: false, foreign_key: true |  

**Association**

* has_many :items
* has_many :purchases
* has_one :private

## privatesテーブル

| Column           | Type         | Options                        | 
| --------         | ------------ | ------------------------------ |
| first_name       | string       | null: false                    |
| last_name        | string       | null: false                    |
| first_name_kana  | string       | null: false                    |      
| last_name_kana   | string       | null: false                    | 
| user             | references   | null: false, foreign_key: true | 

**Association**

* belongs_to :user

## items テーブル

| Column        | Type        | Options                      |
| ------------- | ----------- | ---------------------------- |                  
| title         | string      | null: false                  |
| detail        | text        | null: false                  |
| category      | integer     | null: false                  |
| condition     | integer     | null: false                  |
| postage       | integer     | null: false                  |
| prefecture    | integer     | null: false                  |
| delivery_day  | integer     | null: false                  |
| price         | integer     | null: false                  | 
| user          | references  | null:false, foreign_key: true|
| purchase      | references  | null:false, foreign_key: true|

**Association**

* belongs_to :user
* belongs_to :purchase
* belongs_to_active_hash :prefecture
* belongs_to_active_hash :category
* belongs_to_active_hash :condition
* belongs_to_active_hash :postage
* belongs_to_active_hash :delivery_day


## purchases テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| item      | references | null: false, foreign_key: true |       
| user      | references | null: false, foreign_key: true |
| address   | references | null: false, foreign_key: true |

**Association**

* belongs_to :user
* belongs_to :item
* has_one :address

## addresses　テーブル

| Column       | Type         | Options                        | 
| ------------ | ------------ | ------------------------------ |
| postal_code  | string       | null: false                    |
| prefecture   | integer      | null: false                    |
| city         | string       | null: false                    |
| house_number | string       | null: false                    |      
| apartment    | string       | null: false, default: ""       | 
| phone_number | string       | null: false                    |
| purchase     | references   | null: false, foreign_key: true | 

**Association**

* belongs_to_active_hash :prefecture
* has_one :purchase

## prefectures テーブル

| Column       | Type         | Options                        | 
| --------     | ------------ | ------------------------------ |
| name         | string       | null: false                    |


## categories テーブル

| Column       | Type         | Options                        | 
| --------     | ------------ | -------------------------------|
| name         | string       | null: false                    |

## conditions　テーブル

| Column       | Type         | Options                        | 
| --------     | ------------ | ------------------------------ |
| value        | string       | null: false                    |

## postages テーブル

| Column       | Type         | Options                        | 
| --------     | ------------ | ------------------------------ |
| value        | string       | null: false                    |

## delivery_days テーブル

| Column       | Type         | Options                        | 
| --------     | ------------ | ------------------------------ |
| value         | string       | null: false                   |


