module Jekyll
  class Javadoc < Jekyll::AbstractDocPlugin

    def initialize(tag_name, text, tokens)
      super
    end   

    def create_link(context, content)
      current_release = get_current_version(context)

      base_javadoc_url = context.registers[:site].config["base_javadoc_url"] || 
                         "http://www.gigaspaces.com/docs/JavaDoc%{version}/index.html?%{fqcn}.html"

      fqcn = @class_name.gsub(/\./, "/")

      base_javadoc_url % {:version => current_release, :fqcn => fqcn}
    end
  end
end

Liquid::Template.register_tag('javadoc', Jekyll::Javadoc)