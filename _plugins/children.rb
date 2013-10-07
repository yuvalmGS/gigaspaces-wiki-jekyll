module Jekyll
  class ChildrenTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      "<div id=\"childrentree\"></div>"
    end
  end
end

Liquid::Template.register_tag('children', Jekyll::ChildrenTag)
