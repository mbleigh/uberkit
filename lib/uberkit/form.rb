require File.dirname(__FILE__) + "/forms/builder"
require File.dirname(__FILE__) + "/forms/helper"

ActionView::Base.send(:include, Uberkit::Forms::Helper)