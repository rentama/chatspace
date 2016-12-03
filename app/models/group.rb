class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :messages

  validates :name, presence: true

  def members
    members = ""
    users.each do |user|
      members += user.name + " "
    end
    return "Members: #{members}"
  end
end
