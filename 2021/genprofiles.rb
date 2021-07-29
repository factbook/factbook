###
#  (re)generate profiles in txt from json datasets from (cached) datasets


require_relative 'boot'



def gen_profiles( out_root: nil )

  ## todo/check: clean-up out_root setup somehow - possible? why? why not?
  if out_root.nil?
     out_root = if debug?
                  './tmp/profiles'
                else
                  Mononame.real_path( 'country-profiles@factbook' )
                end
  end


  ## for debugging select some codes
  ## codes = Factbook.codes.select {|code| ['us','au'].include?(code.code) }

  codes = Factbook.codes

  i = 0
  codes.each do |code|
    puts "==> [#{i+1}/#{codes.size}] #{code.format}:"

      json = Webcache.read( code.data_url )
      data = JSON.parse( json )
      data = convert_cia( data )
      data

      profile = Factbook::Profile.parse( data )


      path = "#{out_root}/#{code.region_slug}/#{code.name_slug}.md"

      FileUtils.mkdir_p( File.dirname( path ) )    ## make sure path exist


      puts "Saving #{code.code} - #{code.name} to >#{path}<..."

      buf = String.new('')
      buf << "_#{code.region} / #{code.category}_\n\n"
      buf << "# #{code.name}\n\n"

      buf << profile.to_markdown


      ## note: (auto-)convert to unix newlines only => e.g. universal (e.g. gsub( "\r\n", "\n" ))
      File.open( path, 'w:utf-8', :newline => :universal ) do |f|
        f.write( buf )
      end

    i += 1
  end

  puts "done - saved in (#{out_root})"
end




#######################
## for testing use:
##   ruby 2021/genprofiles.rb

if __FILE__ == $0
  gen_profiles( out_root: './tmp/profiles' )
end

