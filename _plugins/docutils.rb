module DocUtils

  def self.get_current_section(sectionPath)
    if !sectionPath.nil?
      if sectionPath.start_with?("xap")
        isDotNet = sectionPath.end_with?("net");
        isAdmin = sectionPath.end_with?("adm");
        isSecurity = sectionPath.end_with?("sec");
        isMultiSite = sectionPath.end_with?("msr");
        sectionPath = sectionPath.sub("xap","")
        sectionPath = sectionPath.sub("net","")
        sectionPath = sectionPath.sub("adm","")
        sectionPath = sectionPath.sub("sec","")
        sectionPath = sectionPath.sub("msr","")
        version = sectionPath.insert(sectionPath.length - 1, ".")
        if isDotNet 
          "" + version + " C#"
        elsif isAdmin
          return "" + version + " Administration"
        elsif isSecurity
          return "" + version + " Security"
        elsif isMultiSite
          return "" + version + " Multi Site Replication"
        else 
          return "" + version + " Java"
        end
      elsif sectionPath == "sbp" 
        "Solutions &amp; Patterns"
      elsif sectionPath == "api_documentation"
        "API Documentation"
      elsif sectionPath == "early_access"
        "Early Access"
      elsif sectionPath == "product_overview"
        "Product Overview"
      elsif sectionPath == "tutorials"
        "Tutorials"
      elsif sectionPath == "howto"
        "How To"
      elsif sectionPath == "release_notes"
        "Release Notes"
      elsif sectionPath == "rta"
        "Realtime Analytics"
      elsif sectionPath == "faq"
        "FAQ"
      else
        ""
      end
    else
      ""
    end
  end 

  def self.get_current_version(context)
    versionDir = context.environments.first["page"]["url"].split("/")[1]
    if !versionDir.nil?
      if versionDir.start_with?("xap")
        versionDir = versionDir.sub("xap","")
        versionDir = versionDir.sub("net","")
        versionDir = versionDir.sub("adm","")
        versionDir = versionDir.sub("sec","")
        versionDir = versionDir.sub("msr","")
        versionDir.insert(versionDir.length - 1, ".")
      else 
        context.registers[:site].config["latest_xap_release"]
      end
    else
      context.registers[:site].config["latest_xap_release"]
    end
  end 

end
