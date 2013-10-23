module Jekyll
  module Tags
    class Learn < Liquid::Block
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
      end

      def render(context)
        add_learn(context, super)
      end

      def add_learn(context, content)
        output = "Learn more [![Learn more](/attachment_files/navigation/l-more.png)]("
        output << content
        output << "){:target=\"_blank\"}"
      end
    end
  end
end

Liquid::Template.register_tag('learn', Jekyll::Tags::Learn)

