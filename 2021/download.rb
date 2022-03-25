###
#  download all json datasets to Webget cache



require_relative 'boot'


Webget.config.sleep = 0.5     ## sleep 500 ms (that is, 0.5 secs)


def download
  ## for debugging select some codes
  codes = Factbook.codes.select {|code| ['us', 'au'].include?( code.code ) }

  ##codes = Factbook.codes

  i = 0
  codes.each do |code|
    begin ## exception handling as requested in issue #7 -> if one download fails we'll move on to the next one
      puts "==> [#{i+1}/#{codes.size}] #{code.format}:"

      res = Webget.call( code.data_url )  ## get json dataset / page
      if res.status.nok?
        puts "!! ERROR - download json call:"
        pp res
        exit 1
      end

      i += 1
    rescue
      puts "!! ERROR - download json call for '%s' failed! -> moving on to the next code " %[code.data_url]
    end
  end
  puts "bye"
end



#######################
## for testing use:
##   ruby 2021/download.rb

if __FILE__ == $0
  download
end

