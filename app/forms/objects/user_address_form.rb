module Objects
  class UserAddressForm < ::ObjectWrapBaseForm
    attribute :zipcode, :string, default: nil
    attribute :body, :string, default: nil

    # このフォームだけで行いたいvalidationを書ける
    validates :body, length: { maximum: 30 }
  end
end
