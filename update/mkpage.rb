# encoding: utf-8

class OldPage

def save( opts={} )
  ## use output_root - why, why not??
  output_dir = opts[:output_dir] || '.'


##  add country name (cn)  #{cn} - ???

    header =<<EOS
---
layout:       country
title:        #{@cc} - #{@cn}
permalink:    #{@cc}.html
last_updated: #{@last_updated ? @last_updated.strftime('%Y-%m-%d') : '' }
EOS


## note:
##  use double quotes for country name - may include commas e.g Korea, Republic etc.

if @country_info
  header += <<EOS
country_code: #{@country_info.country_code}
country_name: "#{@country_info.country_name}"
country_affiliation: #{@country_info.country_affiliation}
region_code:  #{@country_info.region_code}
region_name:  #{@country_info.region_name}
EOS
else
  ## note: use nothing for now (in YAML default to null - not empty string)
  header += <<EOS
country_code:
country_name:
country_affiliation:
region_code:
region_name:
EOS
end

header += <<EOS
---

EOS


    ## force html encoding to utf-8 in file - why? why not?
    ## header.force_encoding( Encoding::UTF_8 )

  File.open( "#{output_dir}/#{@cc}.html", 'w' ) do |f|
    f.write header
    f.write @html
  end    
end

def save_errors( opts={} )
  name       = opts[:name]       || 'errors.log'
  output_dir = opts[:output_dir] || '.'
  
  ## log encoding erros
  File.open( "#{output_dir}/#{name}", 'a' ) do |f|    ## note: use a(ppend) file mode
    @errors.each do |error| 
      f.write "[#{@cc}] #{error}\n"
    end
  end   
end

end  # class OldPage
