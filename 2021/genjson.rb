###
#  (re)generate json datasets from (cached) datasets


require_relative 'boot'


##
##  todo: mae region_to_slug into a utility method for (re)use - how, why? why not??
def region_to_slug( text )
  ##  change and  =>  n
  ##  change  &   =>  n
  ##  change all spaces to => -
  ##   e.g. East & Southeast Asia          => east-n-southeast-asia
  ##        Central America and Caribbean  => central-america-n-caribbean
  text.downcase.gsub('and', 'n').gsub( '&', 'n' ).gsub( ' ', '-' )
end


def gen_json
=begin
  out_root =  if debug?
                './tmp/json'
              else
                 Mononame.real_path( 'factbook.json@factbook' )
              end
=end

  ## out_root = './tmp/json'
  out_root = '../cache.factbook.json'


  ## for debugging select some codes
  ## codes = Factbook.codes.select {|code| ['us','au'].include?(code.code) }

  codes = Factbook.codes

  i = 0
  codes.each do |code|
    puts "[#{i+1}/#{codes.size}]:"
    pp code

    if code.code == 'wi'  ## 404 Not found --   Western Sahara no longer available??
      ## skip -- do nothing
    else
      url = "https://www.cia.gov/the-world-factbook/geos/#{code.code}.json"

      json = Webcache.read( url )
      data = JSON.parse( json )

      region_slug = region_to_slug( code.region )
      path = "#{out_root}/#{region_slug}/#{code.code}.json"

      FileUtils.mkdir_p( File.dirname( path ) )    ## make sure path exist


      puts "Saving #{code.code}- #{code.name} to >#{path}<..."
      ## note: (auto-)convert to unix newlines only => e.g. universal (e.g. gsub( "\r\n", "\n" ))
      File.open( path, 'w:utf-8', :newline => :universal ) do |f|
        f.write( JSON.pretty_generate( data ) )
      end
    end

    i += 1
  end

  puts "bye"
end


gen_json