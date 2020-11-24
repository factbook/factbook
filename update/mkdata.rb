# encoding: utf-8

require 'pp'

## 3rd party gems
require 'fetcher'


nums =  Factbook.comparisons.to_a   ## e.g. [2147,2119,2002,..]

nums.each_with_index do |num,i|
  ## next if i > 2   ## try just some (first) nums for debugging

  puts "[#{i+1}] #{num}"
  url = "https://www.cia.gov/library/publications/the-world-factbook/rankorder/rawdata_#{num}.txt"
  text = Fetcher.read_utf8!( url )

  recs = Factbook::TableReader.new( text ).read
  pp recs[0..3]

  #############################################
  ## fix: add Factbook::Utils ??? for data_to_csv??

  csv = data_to_csv( recs, ['Pos','Name','Value'] )
  pp csv[0..100]

  File.open( "./build/data/c#{num}.csv", 'w' ) do |f|
    f.write csv
  end
end
