module Jekyll
  class PdfTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      "<i class='fa fa-file-pdf-o fa-lg'></i>"
    end
  end
end

Liquid::Template.register_tag('pdf', Jekyll::PdfTag)
