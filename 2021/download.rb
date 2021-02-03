###
#  download all json datasets



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

    if code.code == 'wi'  ## 404 Not found --   Western Sahara no longer available??
      ## skip -- do nothing
    else
      url = "https://www.cia.gov/the-world-factbook/geos/#{code.code}.json"

      res = Webget.call( url )
      if res.status.nok?
        puts "!! ERROR - download json call:"
        pp res
        exit 1
      end
    end

    i += 1
  end
  puts "bye"
end


