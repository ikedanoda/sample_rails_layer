class UserAddress < ApplicationRecord
  belongs_to :user

  validates :zipcode, presence: true, format: {
    with: /\A[0-9]{7}\z/, message: 'は7桁の数字で入力して下さい。'
  }
  validates :body, presence: true
end
