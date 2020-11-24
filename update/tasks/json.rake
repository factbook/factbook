############################
##  world factbook tasks


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


desc 'generate json for factbook.json repo'
task :json do

  ##  todo: add DEBUG flag to use ./build flag with limit - why? why not?

  out_root = debug? ? './build/factbook.json' : FACTBOOK_JSON_PATH

  i=0
  Factbook.codes.each do |code|
     i += 1
     ### next if i > 3    ## for debuging

     puts "(#{i}) Reading page #{code.code}- #{code.name}..."
     page = read_page( code.code )

     region_slug = region_to_slug( code.region )
     path = "#{out_root}/#{region_slug}/#{code.code}.json"

     ## make sure path exist
     FileUtils.mkdir_p( File.dirname( path ) )

     ### save to json
     puts "  saving a copy to >#{path}<..."
     File.open( path, 'w') do |f|
       f.write JSON.pretty_generate( page.data ) 
     end     
  end
end

