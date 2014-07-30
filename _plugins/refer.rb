require 'kramdown'
module Jekyll
  module Tags
    class Refer < Liquid::Block
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
      end

      def render(context)
      	add_refer(context, super)
      end

      def add_refer(context, content)
      	output = "<i class='fa fa-share fa-lg'  style='color:#3B73AF;'></i>&nbsp;"
        output << content
      end
    end
  end
end

Liquid::Template.register_tag('refer', Jekyll::Tags::Refer)