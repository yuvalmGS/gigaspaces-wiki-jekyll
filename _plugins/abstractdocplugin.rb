module Jekyll
  class AbstractDocPlugin < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @class_name = text.strip
    end

    def get_current_version(context)
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

    def render(context)
      create_link(context, super)
    end

    def create_link(context, content)
      raise "create_link should be implement in subclass"
    end
  end
end
