module Objects
  class UserAddressForm < ::ObjectWrapBaseForm
    attribute :zipcode, :string, default: nil
    attribute :body, :string, default: nil
  end
end
