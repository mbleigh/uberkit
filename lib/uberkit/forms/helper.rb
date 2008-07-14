module Uberkit::Forms::Helper
  def parse_options(*args)
    options = args.extract_options!
    options.merge!(:builder => Uberkit::Forms::Builder)
    options[:html] ||= {}
    class_names = options[:html][:class] ? options[:html][:class].split(" ") : []
    class_names << "uberform"
    class_names << options.delete(:kind).to_s
    options[:html][:class] = class_names.join(" ")
    args << options
  end
  
  def uberform_for(name_or_object_or_array, *args, &proc)
    args = parse_options(*args)
    form_for(name_or_object_or_array, *args, &proc)
  end
  
  def remote_uberform_for(name_or_object_or_array, *args, &proc)
    args = parse_options(*args)
    remote_form_for(name_or_object_or_array, *args, &proc)
  end
end