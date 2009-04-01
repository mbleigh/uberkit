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

  def reverse_field(label_text, field, content, options = {})
    content_tag(:div, :class => "reverse_field#{' required' if options[:required]}#{' labelless' if options[:title].blank?}") do
      result = ""
      unless options[:title].blank?
        result << content_tag(:span, options[:title], :class => "pseudo_label")
      end
      result << content_tag(:div, :class => "pseudo_field") do
        ret = content
        ret << label(field, label_text)
        ret << content_tag(:span, options[:help], :class => 'help') unless options[:help].blank?
        ret << content_tag(:span, options[:description], :class => 'description') unless options[:description].blank?
        ret << "<br/>"
        ret
      end
      result
    end
  end

  def check_box(field, options = {}, *args)
    label_text = options.delete(:label) || field.to_s.titleize
    help = options.delete(:help)
    required = options.delete(:required)
    description = options.delete(:description)
    title = options.delete(:title)
    reverse_field(label_text, field, super(field, options, *args), {:required => required, :help => help, :description => description, :title => title})
  end

  def radio_button(field, tag_value, options = {})
    label_text = options.delete(:label) || tag_value.to_s.titleize
    help = options.delete(:help)
    required = options.delete(:required)
    description = options.delete(:description)
    title = options.delete(:title)
    reverse_field(label_text, field, super(field, tag_value, options), {:required => required, :help => help, :description => description, :title => title} )
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
