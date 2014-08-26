require 'kramdown'

module Jekyll
  class XAPVersion < Liquid::Tag

    @@table97 = Hash.new

   # For now will only build a lookup table for 10.0
   # 11 will need its own lookup table
    @@table100 = Hash.new

    @@table100['spring']            = '3.2'
    @@table100['mongo-java-driver'] = '2.11.2'
    @@table100['antlr4-runtime']    = '4.0'
    @@table100['mongo-datasource']  = '10.0.0-SNAPSHOT'
    @@table100['openjpa']           = '2.0.1'

    @@table100['maven-version']     = '10.0.0-11600-RELEASE'
    @@table100['gshome-directory']     = 'gigaspaces-xap-premium-10.0.0-ga'
    @@table100['default-lookup-group'] = 'gigaspaces-10.0.0-XAPPremium-ga'
    @@table100['build-filename']       = 'gigaspaces-xap-premium-10.0.0-ga-b11600.zip'


    def initialize(tag_name, text, token)
      super
      @key = text
      @key.strip!
    end



    def render(context)

        @current_version = DocUtils.get_current_version(context)

#      puts @@table100
#       puts @current_version

#       if @current_version.start_with?("9.7")
#          output = @@table97[@key]
#       else
          output = @@table100[@key]
#       end

    end


  end
end
 
Liquid::Template.register_tag('version', Jekyll::XAPVersion)
