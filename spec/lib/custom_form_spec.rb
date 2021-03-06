require 'rails_helper'

RSpec.describe CustomForm do
  let(:form) { create(:form, name: "volunteers") }
  let(:view_context) { ActionView::Base.new }

  describe "#valid?" do

    it "should add an error if a field is required" do
      create(:field, name: "t-shirt", required: true, field_type: "text", form: form)
      create(:field, name: "comment", required: false, field_type: "text", form: form)
      custom_form = CustomForm.new(form, nil, view_context)
      custom_form.valid?
      expect(custom_form.errors.count).to eq 1
    end

    it "should return false if there is at last one error" do
      create(:field, name: "t-shirt", required: true, field_type: "text", form: form)
      custom_form = CustomForm.new(form, nil, view_context)
      expect(custom_form.valid?).to be false
    end

    it "should add an error if no email is specified" do
      create(:field, name: "name", required: true, field_type: "text", form: form)
      attributes = { "name" => "John Smith" }
      custom_form = CustomForm.new(form, nil, view_context, attributes: attributes, email: true)
      custom_form.valid?
      expect(custom_form.errors.count).to eq 1
    end

  end

  describe "#save" do

    it "does not save if the form is not valid" do
      create(:field, name: "t-shirt", required: true, field_type: "text", form: form)
      custom_form = CustomForm.new(form, nil, view_context)
      expect(custom_form.save).to be false
    end

    it "saves the fields to the database if the form is valid" do
      create(:field, name: "comment", required: false, field_type: "text", form: form)
      create(:field, name: "sector", required: true, field_type: "select_field", options: ["Fun park", "Animation"], form: form)
      attributes = { "comment" => "Un commentaire", "sector" => "0" }
      custom_form = CustomForm.new(form, nil, view_context, attributes: attributes)
      expect(custom_form.save).to be true
      custom_form.completed_form.completed_fields.each do |field|
        expect(field.value).to eq attributes[field.field.name]
      end
    end

    it "should not send a confirmation if the params is not specified" do
      create(:field, name: "name", required: true, field_type: "text", form: form)
      attributes = { "name" => "John Smith", "email" => "john@smith.com" }
      custom_form = CustomForm.new(form, nil, view_context, attributes: attributes)
      expect { custom_form.save }.to change { ActionMailer::Base.deliveries.count }.by(0)
    end

    it "should send a confirmation email" do
      create(:field, name: "name", required: true, field_type: "text", form: form)
      attributes = { "name" => "John Smith", "email" => "john@smith.com" }
      custom_form = CustomForm.new(form, nil, view_context, attributes: attributes, email: true)
      expect { custom_form.save }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

  end

end