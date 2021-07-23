###
#  download all json datasets



require_relative 'boot'


Webget.config.sleep = 0.5     ## sleep 500 ms (that is, 0.5 secs)


def download
  ## for debugging select some codes
  ## codes = Factbook.codes.select {|code| ['us', 'au'].include?( code.code ) }

  codes = Factbook.codes

  i = 0
  codes.each do |code|
    puts "[#{i+1}/#{codes.size}]:"
    pp code

    res = Webget.call( code.data_url )  ## get json dataset / page
    if res.status.nok?
      puts "!! ERROR - download json call:"
      pp res
      exit 1
    end

    i += 1
  end
  puts "bye"
end



#######################
## for testing use:
##   ruby 2021/download.rb

download    if __FILE__ == $0


