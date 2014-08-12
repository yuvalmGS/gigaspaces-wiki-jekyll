module Jekyll
  class ReferToTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
     	output = "<i class='fa fa-share fa-lg'  style='color:#3B73AF;'></i>&nbsp;"
    end
  end
end

Liquid::Template.register_tag('referto', Jekyll::ReferToTag)