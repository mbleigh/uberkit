module Uberkit
  class Displayer
    include ActionView::Helpers::CaptureHelper
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::TagHelper

    def initialize(template)
      @template = template
    end

    def is_haml?
      false
    end
  end
end