module Objects
  class UserProfileForm < ::ObjectWrapBaseForm
    attribute :last_name, :string, default: nil
    attribute :first_name, :string, default: nil
  end
end
