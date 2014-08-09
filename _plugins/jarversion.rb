require 'kramdown'

module Jekyll
  class JarVersion < Liquid::Tag

    @@table97 = Hash.new

   # For now will only build a lookup table for 10.0
   # 11 will need its own lookup table
    @@table100 = Hash.new
    @@table100['spring'] = '3.2'
    @@table100['mongo-java-driver'] = '2.11.2'
    @@table100['antlr4-runtime']    = '4.0'
    @@table100['mongo-datasource']  = '10.0.0-SNAPSHOT'

    def initialize(tag_name, text, token)
      super
      @key = text
    end



    def render(context)

        @current_version = DocUtils.get_current_version(context)

#       puts @@table100
#       puts @current_version

#       if @current_version.start_with?("9.7")
#          output = @@table97[@key]
#       else
          output = @@table100[@key]
#       end

    end


  end
end
 
Liquid::Template.register_tag('jarversion', Jekyll::JarVersion)
