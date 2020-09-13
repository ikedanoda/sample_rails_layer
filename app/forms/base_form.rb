class BaseForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Serialization

  private

    # formが抱えるmodelのvalidationをここで行いerrorがあったらコピー
    # formではなくmodelにあるのが適切なvalidationを利用する時用
    # formとmodelでattributeを揃える必要あり
    def copy_validation_errors(model:, context: nil)
      errors.merge!(model.errors) unless model.valid?(context)
    end
end
