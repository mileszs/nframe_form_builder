module NframeFormHelper
      
  def wrapping(type, field_name, label, field, options = {})
    help = %Q{<br /><small><span class="help">#{options[:help]}</span></small>} if options[:help]
    more_help = "&nbsp;" + @template.image_tag('help.png', :alt => "help", :id => options[:more_help]) if options[:more_help]
    to_return = []
    to_return << %Q{<p class="#{options[:class]}">}

    if !(["radio", "check", "submit"].include?(type))
      to_return << %Q{<label for="#{field_name}" class="#{options[:class]}">#{label}#{help}</label>} unless ["radio","check", "submit"].include?(type)
      to_return << field
      to_return << more_help
    elsif ["radio", "check"].include?(type)
      to_return << %Q{<label for="#{field_name}">&nbsp;</label>}
      to_return << field
      to_return << %Q{<label for="#{field_name}" class="#{options[:class]}">#{label}</label>}
      to_return << more_help
    else
      to_return << field
      to_return << more_help
    end

    to_return << %Q{</p>}
  end

  def semantic_group(type, field_name, label, fields, options = {})
    help = %Q{<span class="help">#{options[:help]}</span>} if options[:help]
    to_return = []
    to_return << %Q{<div class="#{type}-fields #{options[:class]}">}
    to_return << %Q{<label for="#{field_name}">#{label}#{help}</label>}
    to_return << %Q{<div class="input">}    
    to_return << fields.join
    to_return << %Q{</div></div>}
  end

  def boolean_field_wrapper(input, name, value, text, help = nil)
    help = %Q{<br /><small>#{help}</small>} if help
    field = []
    field << %Q{<label>&nbsp;</label>}
    field << input
    field << %Q{<label>#{text} #{help}</label>}
    field
  end

  def check_box_tag_group(name, values, options = {})
    selections = []
    values.each do |item|
      if item.is_a?(Hash)
        value = item[:value]
        text = item[:label]
        help = item.delete(:help)
      else
        value = item
        text = item
      end
      box = check_box_tag(name, value)
      selections << boolean_field_wrapper(box, name, value, text)
    end
    label = options[:label]
    semantic_group("check-box", name, label, selections, options)    
  end      

end
