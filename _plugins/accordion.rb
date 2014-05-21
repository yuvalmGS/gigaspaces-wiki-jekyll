require 'securerandom'

module Jekyll
  module Tags

    class Accordion < Liquid::Block
      include Liquid::StandardFilters

      @@id = nil

    def Accordion.id
        return @@id
    end

     def Accordion.id= (x)
         @@id = x
     end

      def initialize(tag_name, markup, tokens)
        super
        if markup.empty?
          $div_id = "generic"
        else
          @@id  = markup.strip.sub("id=", "")
        end
      end

      def render(context)
      	add_togglecloak(context, super)
      end

      def add_togglecloak(context, content)
#        output = "<div class='panel-group' id='#{$div_id}'>"
         output = "<div class='panel-group' id='#{Accordion.id}'>"
        output << Kramdown::Document.new(content).to_html
        output << "</div>"
      end
    end

    class Accord < Liquid::Block
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
        @title = markup.strip
      end

      def render(context)
      	add_gcloak(context, super)
      end



      def add_gcloak(context, content)

        random_string = SecureRandom.hex

        output =   "<div class='panel panel-default'>
                     <div class='panel-heading'>
                       <h4 class='panel-title'>
                         <a data-toggle='collapse' data-parent='##{Accordion.id}' href='##{random_string}'>
                          #{@title}
                         </a>
                       </h4>
                     </div>
                     <div id='#{random_string}' class='panel-collapse collapse'>
                       <div class='panel-body'>"
        output << Kramdown::Document.new(content).to_html
        output << "</div></div></div>"
      end
    end
  end
end

Liquid::Template.register_tag('accordion', Jekyll::Tags::Accordion)
Liquid::Template.register_tag('accord', Jekyll::Tags::Accord)


