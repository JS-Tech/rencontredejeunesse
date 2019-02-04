class CustomForm
  I18N_PATH = "helpers.label.custom_form"
  TEMPLATE_PATH = File.join(Rails.root, 'lib', 'custom_form', 'template.html.erb')

  attr_reader :completed_form, :errors

  def initialize(form, url, view, attributes: {})
    @form = form
    @url = url
    @view = view
    @attributes = attributes
    @errors = []
    @fields = form.fields
  end

  def assign_attributes(attributes)
    @attributes = attributes
  end

  def valid?
    @errors = []
    @fields.each do |field|
      if field.required && @attributes[field.name].blank?
        field_name = I18n.t("#{I18N_PATH}.#{field.name}")
        @errors << I18n.t("errors.messages.required", attribute: field_name)
      end
    end
    return !@errors.any?
  end

  def save
    if valid?
      @completed_form = Form::CompletedForm.create!(form: @form)
      @fields.each do |field|
        Form::CompletedField.create!(field: field, value: @attributes[field.name], completed_form: @completed_form)
      end
      return true
    else
      return false
    end
  end

  def render
    return @view.form_for :custom_form, url: @url, html: { id: "custom_form" } do |form|
      content = ERB.new(File.read(TEMPLATE_PATH)).result(binding).html_safe
    end
  end

  def self.display(completed_form)
    completed_fields = completed_form.completed_fields.includes(:field)
    completed_fields.each do |field|
      label, value = Field.display(field)
      yield(label, value)
    end
  end

end