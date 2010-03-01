require 'nframe_form_helper'
class NframeFormBuilder < ActionView::Helpers::FormBuilder
  include NframeFormHelper

  def field_settings(method, options = {}, tag_value = nil)
    field_name = "#{@object_name}_#{method.to_s}"
    default_label = tag_value.nil? ? "#{method.to_s.gsub(/\_/, " ").titleize}" : "#{tag_value.to_s.gsub(/\_/, " ")}"
    label = options[:label] ? options.delete(:label) : default_label
    options[:class] ||= ""
    options[:class] += options[:required] ? " required" : ""
    [field_name, label, options]
  end

  def text_field(method, options = {})
    field_name, label, options = field_settings(method, options)
    wrapping("text", field_name, label, super, options)
  end

  def money_field(method, options = {})
    options[:value] ||= ''
    options[:value] += format('%.2f', @object.send(method)) if @object.send(method)
    text_field(method, options)
  end

  def file_field(method, options = {})
    field_name, label, options = field_settings(method, options)
    wrapping("file", field_name, label, super, options)
  end

  def datetime_select(method, options = {})
    field_name, label, options = field_settings(method, options)
    wrapping("datetime", field_name, label, super, options)
  end

  def date_select(method, options = {})
    field_name, label, options = field_settings(method, options)
    wrapping("date", field_name, label, super, options)
  end

  def radio_button(method, tag_value, options = {})
    field_name, label, options = field_settings(method, options)
    wrapping("radio", field_name, label, super, options)
  end

  def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
    field_name, label, options = field_settings(method, options)
    wrapping("check", field_name, label, super, options)
  end

  def select(method, choices, options = {}, html_options = {})
    field_name, label, options = field_settings(method, options)
    html_options[:class] = options[:class]
    wrapping("select", field_name, label, super, options)
  end

  def password_field(method, options = {})
    field_name, label, options = field_settings(method, options)
    wrapping("password", field_name, label, super, options)
  end

  def text_area(method, options = {})
    field_name, label, options = field_settings(method, options)
    wrapping("textarea", field_name, label, super, options)
  end

  def submit(method, options = {})
    field_name, label, options = field_settings(method, options.merge( :label => "&nbsp;"))
    wrapping("submit", field_name, label, super, options)
  end

  def submit_and_cancel(submit_name = 'Submit', cancel_name = 'Cancel', options = {})
    submit_button = @template.submit_tag(submit_name, options)
    cancel_button = @template.submit_tag(cancel_name, options)
    wrapping("submit", nil, "", submit_button+cancel_button, options)
  end

end

