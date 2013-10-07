module Jekyll
  module Tags
    class InitTab < Liquid::Block
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
      end

      def render(context)
      	add_div_for_tab(context, super)
      end

      def add_div_for_tab(context, code)
      	output = "<div class='tabsection'><ul class='nav nav-tabs'></ul><div class='tab-content'>"
        output << Kramdown::Document.new(code).to_html
        output << "</div></div>"
        output
      end
    end

    class TabContent < Liquid::Block
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
        @title = markup.strip
      end

      def render(context)
      	add_div_for_tabcontent(context, super)
      end

      def add_div_for_tabcontent(context, code)
      	output = "<div class='tab-pane' id='#{@title.downcase.gsub(/(\s)/, "_")}'
      		title='#{@title}'>"
        output << Kramdown::Document.new(code).to_html
        output << "</div>"
      end
    end
  end
end

Liquid::Template.register_tag('inittab', Jekyll::Tags::InitTab)
Liquid::Template.register_tag('tabcontent', Jekyll::Tags::TabContent)