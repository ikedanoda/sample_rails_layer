class RegistrationsController < ApplicationController
  before_action :set_user

  def show
    @registration_form = RegistrationForm.new(
      @user.build_user_profile,
      @user.build_user_address
    )
  end

  def confirm
    @registration_form = RegistrationForm.new(
      @user.build_user_profile,
      @user.build_user_address,
      registration_form_params
    )

    return render :show unless @registration_form.valid?
  end

  def update
    @registration_form = RegistrationForm.new(
      @user.build_user_profile,
      @user.build_user_address,
      registration_form_params
    )

    @registration_form.valid!

    # workflowの処理
  end

  private

    def set_user
      @user = User.last!
    end

    def registration_form_params
      params.require(:registration_form).permit(
        :agreement,
        user_profile_form: [
          :last_name,
          :first_name
        ],
        user_address_form: [
          :zipcode,
          :body
        ]
      )
    end
end
