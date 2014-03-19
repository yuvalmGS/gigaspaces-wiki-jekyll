require 'kramdown'
module Jekyll
  module Tags
    class JavaNet < Liquid::Block
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
      end

      def render(context)
      	add_refer(context, super)
      end

      def add_refer(context, content)

        javaURL = context.registers[:site].config["latest_java_url"]
        netURL = context.registers[:site].config["latest_net_url"]

        output = "([Java version]("+ javaURL + content + ") \\| [.Net version](" + netURL + content + "))"
      end
    end
  end
end

Liquid::Template.register_tag('javanet', Jekyll::Tags::JavaNet)