###
#  download all pages
#
#
#
#  use to run:
#   yo -r ./workflow/download.rb -f workflow/Flowfile.rb download



require_relative 'boot'


Webget.config.sleep = 1

def download

  ## for debugging select some codes
  ## codes = Factbook.codes.select {|code| ['us', 'au'].include?(code.code) }

  codes = Factbook.codes

  i = 0
  codes.each do |code|
    puts "[#{i+1}/#{codes.size}]:"
    pp code

    url = "https://www.cia.gov/library/publications/the-world-factbook/geos/#{code.code}.html"

    res = Webget.page( url )
    if res.status.nok?
      puts "!! ERROR - download page:"
      pp res
      exit 1
    end

    i += 1
  end
  puts "bye"
end



