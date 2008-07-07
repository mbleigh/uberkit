module Uberkit
  module Menu
    def ubermenu(options = {}, &block)
      nav = NavigationMenu.new(self,options)
      yield nav
      concat(nav.to_html, block.binding) if nav.actions.any?
    end

    class NavigationMenu < Uberkit::Displayer
      def initialize(template,options = {})
        super(template)
        @actions = []
        @subnavs = []
        @id = options.delete(:id)
        @class_name = options.delete(:class)
      end

      def action_wrapper(contents, options = {}, url_for_options = {})
        classes = Array.new        
        classes << "first" if @actions.first == [contents, options, url_for_options]
        classes << "last" if @actions.last == [contents, options, url_for_options]
        classes << "current" if merits_current?(contents,options,url_for_options)
        classes << "disabled" if options.delete(:disabled)    
        classes << classes.join("_") if classes.size > 1
        content_tag(:li, contents, :class => classes.join(" "))
      end

      def merits_current?(contents,options={},url_for_options={})
        if options[:force_current]
          return true if options.delete(:current) == true && !options[:disabled]
        else
          return true if (options.delete(:current) == true || (!url_for_options.is_a?(Symbol) && (@template.current_page?(url_for_options)) && url_for_options != {}) and !options[:disabled])
        end
         false
      end

      def action(name, options = {}, html_options = {})
        wrapper_options = { :current => html_options.delete(:current), :disabled => html_options.delete(:disabled), :force_current => html_options.delete(:force_current), :url => options }
        @actions << [@template.link_to(name,options,html_options), wrapper_options, options]
      end

      def actions
        @actions
      end

      def remote_action(name, options = {}, html_options = {})
        wrapper_options = { :current => options.delete(:current), :disabled => options.delete(:disabled), :force_current => options.delete(:force_current), :url => options[:url] }
        @actions << [@template.link_to_remote(name,options,html_options), wrapper_options, options[:url]]
      end

      def custom_action(options = {}, &block)
        options[:force_current] = true
        @actions << [capture(&block), options, {}]
      end

      def submenu(name, options = {}, html_options = {}, &block)
        subnav = NavigationMenu.new(@template,html_options)
        @subnavs << subnav
        yield subnav

        if subnav.actions.any?
          if options == :delegate
            @actions << [@template.link_to(name, subnav.actions.first[1][:url]) + subnav.to_html, {:current => subnav.any_current?, :url => subnav.actions.first[1][:url]}, options]
          else
            @actions << [@template.link_to(name,options,html_options) + subnav.to_html, {:current => subnav.any_current?, :url => options}, options] if subnav.actions.any?
          end
        end
      end

      def any_current?
        @actions.select{|a| merits_current?(*a)}.any?
      end

      def build
        content_tag :ul, @actions.collect{|a| action_wrapper(*a)}.join("\n"),
                    :id => @id,
                    :class => @class_name
      end
      alias :to_html :build
    end
  end
end