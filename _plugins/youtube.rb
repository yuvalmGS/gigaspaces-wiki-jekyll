
# Example usage: {% lightbox 2012/abc.png, Title of Image, Alt Title %}
require 'kramdown'

module Jekyll
  class VideoTag < Liquid::Tag
    def initialize(tag_name, text, token)
      super
      @text = text
    end



  def render(context)
    path, title, alt = @text.split('|').map(&:strip)
    output ="<div class=\"row\">
       <div style=\"float:left; padding-left:15px;padding-right:0px;position:relative;margin-left:0px;margin-right:0px;\">
        <p><a href=\"http://www.youtube.com/watch?v=#{path}\" data-width=\"853\" data-height=\"480\" data-toggle=\"lightbox\"> <img src=\"/attachment_files/navigation/video.jpeg\" class=\"img-responsive\"></a></p>
       </div>
    </div>"
    end
  end
end
 
Liquid::Template.register_tag('youtube', Jekyll::VideoTag)
