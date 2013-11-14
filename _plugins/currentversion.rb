require 'kramdown'
module Jekyll
  class CurrentVersion < Jekyll::AbstractDocPlugin
    include Liquid::StandardFilters

    def initialize(tag_name, markup, tokens)
      super
    end

    def render(context)
      get_current_version(context)
    end
  end
end

Liquid::Template.register_tag('currentversion', Jekyll::CurrentVersion)