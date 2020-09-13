class ObjectWrapBaseForm < ::BaseForm
  attr_reader :model

  def initialize(model:, params:)
    @model = model
    @params = params

    super(@params)
    @model.assign_attributes(model_params(params: @params)) if params.present?

    sync! if needed_sync?
  end

  def valid?(context = nil)
    super(context)

    copy_validation_errors(model: @model, context: context)

    errors.blank?
  end

  private

    # form objectとmodelの内容を同期する。
    # modelがnew_recordの時はform objectのdefault値を利用するためsyncしない。
    def sync!
      sync_attributes.each_key do |attribute|
        next if skip_set_attribute?(model: @model, attribute: attribute)

        model_attribute = @model.send(attribute)
        send("#{attribute}=", model_attribute)
      end
    end

    def needed_sync?
      return true if @params.blank? && @model.persisted?
    end

    def sync_attributes
      attributes.except(*except_sync_attributes)
    end

    def except_sync_attributes
      []
    end

    def skip_set_attribute?(model:, attribute:) # rubocop:disable Lint/UnusedMethodArgument
      false
    end

    # modelに渡すparams. 加工が必要な際にoverrideする
    def model_params(params:)
      params.except(*except_sync_attributes)
    end
end
