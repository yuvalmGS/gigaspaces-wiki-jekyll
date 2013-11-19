require 'kramdown'
module Jekyll
  class CurrentSection < Liquid::Tag
    include Liquid::StandardFilters

    def initialize(tag_name, markup, tokens)
      super
    end

    def render(context)
      get_current_section(context)
    end

    def get_current_section(context)
      sectionPath = context.environments.first["page"]["url"].split("/")[1]
      if !sectionPath.nil?
        if sectionPath.start_with?("xap")
       	  isDotNet = sectionPath.end_with?("net"); 
          sectionPath = sectionPath.sub("xap","")
          sectionPath = sectionPath.sub("net","")
          version = sectionPath.insert(sectionPath.length - 1, ".")
          if isDotNet 
            "XAP.NET " + version 
          else 
            return "XAP " + version
          end
        elsif sectionPath == "sbp" 
          "Solutions &amp; Best Practices"
        elsif sectionPath == "api_documentation"
          "API Documentation"
        elsif sectionPath == "early_access"
          "Early Access"
        elsif sectionPath == "product_overview"
          "Product Overview"
        elsif sectionPath == "java_tutorial"
          "Java Tutorial"
        else
          ""
        end
      else
        ""
      end
    end 
  end
end

Liquid::Template.register_tag('currentsection', Jekyll::CurrentSection)