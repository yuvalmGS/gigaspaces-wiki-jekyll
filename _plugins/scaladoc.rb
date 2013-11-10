module Jekyll
  class Scaladoc < Jekyll::AbstractDocPlugin

    def initialize(tag_name, text, tokens)
      super
    end

    def create_link(context, content)
      current_release = get_current_version(context)

      base_scaladoc_url = context.registers[:site].config["base_scaladoc_url"] || 
                         "http://www.gigaspaces.com/docs/scaladocs%{version}/#%{fqcn}"

      base_scaladoc_url % {:version => current_release, :fqcn => @class_name}
    end
  end
end

Liquid::Template.register_tag('scaladoc', Jekyll::Scaladoc)