require 'kramdown'
module Jekyll
  module Tags
    class CurrentVersion < Liquid::Tag
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
      end

      def render(context)
        versionDir = context.environments.first["page"]["url"].split("/")[1]
        if !versionDir.nil?
          if versionDir.start_with?("xap")
            versionDir = versionDir.sub("xap","")
            versionDir = versionDir.sub("net","")
            versionDir.insert(versionDir.length - 1, ".")
          else 
            context.registers[:site].config["latest_xap_release"]
          end
        else
          context.registers[:site].config["latest_xap_release"]
        end 
      end

    end
  end
end

Liquid::Template.register_tag('currentversion', Jekyll::Tags::CurrentVersion)