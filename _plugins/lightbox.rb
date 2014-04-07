
# Example usage: {% lightbox 2012/abc.png, Title of Image, Alt Title %}
require 'kramdown'

module Jekyll
  class LightboxTag < Liquid::Tag
    def initialize(tag_name, text, token)
      super
      @text = text
    end


  def render(context)
    path, title, alt = @text.split('|').map(&:strip)
    output ="<div class=\"container\">
      <div class=\"row\">
        <div style=\"float:left;width:150px;height=140px; padding-left:0px;padding-right:0px;position:relative;margin-left:0px;margin-right:0px;\">
         <p>
          <a  href=\"#{path}\" data-toggle=\"lightbox\" data-title=\"#{title}\">
             <img src=\"#{path}\" class=\"img-responsive img-rounded\"> #{title}
          </a>
         </p>
        </div>
      </div>
    </div>"
    end
  end
end
 
Liquid::Template.register_tag('popup', Jekyll::LightboxTag)

