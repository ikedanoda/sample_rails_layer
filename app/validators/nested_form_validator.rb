# frozen_string_literal: true

class NestedFormValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, value)
    Array(value).each do |nested_object|
      next if nested_object.valid?

      nested_object.errors.full_messages.each do |full_message|
        record.errors.add(:base, full_message)
      end
    end
  end
end
