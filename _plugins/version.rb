require 'kramdown'

module Jekyll
  class XAPVersion < Liquid::Tag

# Version 9.7
    @@table97 = Hash.new
    @@table97['maven-version']        = '9.7.0-10496-RELEASE'
    @@table97['gshome-directory']     = 'gigaspaces-xap-premium-9.7.0-ga'
    @@table97['default-lookup-group'] = 'gigaspaces-9.7.0-XAPPremium-ga'
    @@table97['build-filename']       = 'gigaspaces-xap-premium-9.7.0-ga-b10496.zip'
    @@table97['xap-version']          = '9.7.0'
    @@table97['xap-release']          = '9.7'
    @@table97['msi-filename']         = 'GigaSpaces-XAP.NET-Premium-9.7.0.10496-GA-x86.msi'
    @@table97['gshome-net-directory'] = 'XAP.NET 9.7.0 x86'

# Version 10.0
    @@table100 = Hash.new
    @@table100['spring']            = '3.2'
    @@table100['mongo-java-driver'] = '2.11.2'
    @@table100['antlr4-runtime']    = '4.0'
    @@table100['mongo-datasource']  = '10.0.0-SNAPSHOT'
    @@table100['openjpa']           = '2.0.1'

    @@table100['maven-version']        = '10.0.0-11600-RELEASE'
    @@table100['gshome-directory']     = 'gigaspaces-xap-premium-10.0.0-ga'
    @@table100['default-lookup-group'] = 'gigaspaces-10.0.0-XAPPremium-ga'
    @@table100['build-filename']       = 'gigaspaces-xap-premium-10.0.0-ga-b11600.zip'
    @@table100['xap-version']          = '10.0.0'
    @@table100['xap-release']          = '10.0'

    @@table100['msi-filename']          = 'GigaSpaces-XAP.NET-Premium-10.0.0.11600-GA-x86.msi'
    @@table100['gshome-net-directory']  = 'XAP.NET 10.0.0 x86'




# Repeat the table for new version

    def initialize(tag_name, text, token)
      super
      @key = text
      @key.strip!
    end



    def render(context)

        @current_version = DocUtils.get_current_version(context)

#      puts @@table100
#      puts @current_version

       if @current_version.start_with?("9.7")
          output = @@table97[@key]
       else
          output = @@table100[@key]
       end

    end


  end
end
 
Liquid::Template.register_tag('version', Jekyll::XAPVersion)
