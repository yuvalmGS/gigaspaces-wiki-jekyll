require 'kramdown'
module Jekyll
  module Tags
    class Summary < Liquid::Block
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
        if markup.nil?
          @section = false
        else
          if markup =~ /section/
            @section = true
          else
            @section = false
          end
        end
      end

      def render(context)
      	add_summary(context, super)
      end

      def add_summary(context, content)
      	output = "<div class='panel panel-primary'><div class='panel-heading'><h3 class='panel-title'>"        
        #if @section
        #  output << "<strong>Section Summary: </strong>"
        #else
        #  output << "<strong>Summary: </strong></h3></p>"
        #end
        output << Kramdown::Document.new(content).to_html
        output << "</p>"
        if @section
          output << "</div></div>"
        else
          output << "</div><div class='panel-body'><ul class='nav nav-pills' id='summarypanel'></ul></div></div>"
        end
      end
    end
  end
end

Liquid::Template.register_tag('summary', Jekyll::Tags::Summary)