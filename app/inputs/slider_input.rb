class SliderInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    "<div class='slider-input'></div>#{@builder.hidden_field(attribute_name, input_html_options)}"
  end
end
