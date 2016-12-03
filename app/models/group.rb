class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :messages

  validates :name, presence: true

  def member_names
    users_names = users.map(&:name)
    return "Members: #{users_names.join(" ")}"
  end
end
