module Jekyll
  class DownloadTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      "<i class='fa fa-download'></i>"
    end
  end
end

Liquid::Template.register_tag('download', Jekyll::DownloadTag)
