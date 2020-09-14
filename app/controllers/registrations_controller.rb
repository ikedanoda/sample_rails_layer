class RegistrationsController < ApplicationController
  before_action :set_user

  def show
    @registration_form = RegistrationForm.new(
      target_user_profile,
      target_user_address
    )
  end

  def confirm
    @registration_form = RegistrationForm.new(
      target_user_profile,
      target_user_address,
      registration_form_params
    )

    return render :show unless @registration_form.valid?
  end

  def create
    @registration_form = RegistrationForm.new(
      target_user_profile,
      target_user_address,
      registration_form_params
    )

    @registration_form.validate!

    # workflowの処理
    ::Users::RegistrationWorkflow.run!(
      user_profile: @registration_form.user_profile_form.model,
      user_address: @registration_form.user_address_form.model
    )

    redirect_to root_path, notice: '登録完了しました！'
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

    def target_user_profile
      @user.user_profile || @user.build_user_profile
    end

    def target_user_address
      @user.user_address || @user.build_user_address
    end
end
