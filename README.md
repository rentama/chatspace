#DB設計

##テーブル

* users
* groups
* messages
* user_group_ties

##アソシエーション

###userモデル

* has_many :messages
* has_many :group_users
* has_many :groups, through: :group_users

###groupモデル

* has_many :group_users
* has_many :users, through: :group_users
* has_many :messages

###messageモデル

* belongs_to :user
* belongs_to :group

###group_userモデル

* belongs_to :user
* belongs_to :group

##テーブルのカラム(カラムの型)

###usersテーブル

* name(string) null: false
* group_id(integer)
* deviseによるカラム諸々

###groupsテーブル

* name(string) null: false

###messagesテーブル

* body(text) add_index
* image(string) add_index
* user_id(integer)
* group_id(integer)

###group_usersテーブル

* user_id(references) add_index
* group_id(references) add_index
