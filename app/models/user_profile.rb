class UserProfile < ApplicationRecord
  belongs_to :user

  validates :last_name, presence: true
  validates :first_name, presence: true
end
