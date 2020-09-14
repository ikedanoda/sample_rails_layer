# frozen_string_literal: true

module Users
  class RegistrationWorkflow < ::ActiveInteraction::Base
    record :user_profile
    record :user_address

    def execute
      ActiveRecord::Base.transaction do
        user_profile.save!
        user_address.save!
      end

      # メール通知必要な場合はここで入れる
      # ::Users::RegistrationMailer.complete(user: user).deliver_later
    end
  end
end
