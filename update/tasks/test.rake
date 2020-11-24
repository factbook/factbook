

task :testreg do
   ## test codes with region (folder)
   codes = Factbook.codes
   codes.each do |code|   
     region_slug = code.region.downcase.gsub('and', 'n').gsub( '&', 'n' ).gsub( ' ', '-' )
     puts "#{region_slug}/#{code.code}  -- #{code.name}"
   end
end


task :testbn do
  page = read_page( 'bn' )
end

task :testau do
  page = read_page( 'au' )
end

