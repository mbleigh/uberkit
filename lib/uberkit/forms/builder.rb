class Uberkit::Forms::Builder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  
  helpers = field_helpers + %w(date_select datetime_select time_select select html_area state_select country_select check_box) - %w(hidden_field label fields_for) 
  
  helpers.each do |name|
    define_method(name) do |field, *args|
      options = args.extract_options!
      class_names = array_from_classes(options[:class])
      class_names << name
      options[:class] = class_names.join(" ")
      args << options
      generic_field(options[:label],field,super(field,*args),{:description => options.delete(:description), :help => options.delete(:help), :required => options.delete(:required)})
    end
  end
  
  def generic_field(label_text,field,content,options = {})
    required = options.delete(:required)
    content_tag(:div, :class => "field_row#{' required' if required}#{' labelless' if label_text == ""}") do
      ret = label(field, (label_text || field.to_s.titleize).to_s + ":") unless label_text == ""
      ret << content
      ret << content_tag(:span, options.delete(:help), :class => "help") if options[:help]
      ret << content_tag(:span, options.delete(:description), :class => "description") if options[:description]
      ret << "<br/>"
      ret
    end
  end

  def check_box(field, options = {}, checked_value = "1", unchecked_value = "0")
    label_text = options.delete(:label) || field.to_s.titleize
    help = options.delete(:help)
    description = options.delete(:description)

    content_tag(:div, :class => "check_box_row#{' require' if options.delete(:required)}#{' labelless' if label_text.blank?}") do
      ret = super(field, options, checked_value, unchecked_value)
      ret << label(field, label_text)
      ret << content_tag(:span, help, :class => 'help') unless help.blank?
      ret << content_tag(:span, description, :class => 'description') unless description.blank?
      ret << "<br/>"
      ret
    end
  end
  
  def submit(text)
    content_tag(:button, text, :type => "submit")
  end
  
  def custom(options = {}, &block)
    concat("<div class='field_row#{' labelless' unless options[:label]}'>#{"<label#{" for='#{options[:for]}'" if options[:for]}>#{options[:label] + ":" if options[:label]}</label>" if options[:label]}<div class='pseudo_field'>",block.binding)
    yield
    concat("</div> <br/></div>",block.binding)
  end 
  
  def array_from_classes(html_classes)
    html_classes ? html_classes.split(" ") : []
  end
  
  def fieldset(legend=nil,&block)
    concat("<fieldset>#{"<legend>#{legend}</legend>" if legend}")
    yield
    concat("</fieldset>")
  end
  
  def output_buffer
    @template.output_buffer
  end
  
  def output_buffer=(buf)
    @template.output_buffer = buf
  end
  
  def is_haml?; false end
end
