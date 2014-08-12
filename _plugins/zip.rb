module Jekyll
  class ZipTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      "<i class='fa fa-file-archive-o fa-lg'></i>"
    end
  end
end

Liquid::Template.register_tag('zip', Jekyll::ZipTag)
