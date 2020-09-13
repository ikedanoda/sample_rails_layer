class RegistrationForm < ::BaseForm
  concerning :UserProfileFormBuilder do
    included do
      attr_reader :user_profile_form

      validates :user_profile_form, nested_form: true

      def user_profile
        @profile_form.model
      end

      private

      def build_user_profile_form(user_profile:, params:)
        ::Objects::UserProfileForm.new(
          model: user_profile,
          params: params
        )
      end
    end
  end

  concerning :UserAddressFormBuilder do
    included do
      attr_reader :user_address_form

      validates :user_address_form, nested_form: true

      def investor_address
        @user_address_form.model
      end

      private

      def build_user_address_form(user_address:, params:)
        ::Objects::UserAddressForm.new(
          model: user_address,
          params: params
        )
      end
    end
  end

  CHILD_FORM_KEYS = [
    :user_profile_form,
    :user_address_form
  ].freeze

  attribute :agreement, :boolean, default: false

  validates :agreement, acceptance: true

  def initialize(
    user_profile,
    user_address,
    params = {}
  )
    @user_profile_form = build_user_profile_form(
      user_profile: user_profile,
      params: params[:user_profile_form] || {}
    )
    @user_address_form = build_user_address_form(
      user_address: user_address,
      params: params[:user_address_form] || {}
    )

    super(params.except(*CHILD_FORM_KEYS))
  end
end
