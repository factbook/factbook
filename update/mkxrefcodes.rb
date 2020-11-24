# encoding: utf-8

require 'pp'

require 'textutils'
require 'nokogiri'

##########
# note:
#   remove old discontinued countries e.g.:  - why? why not???
#     Western Samoa,-,-,-,-              => see Samoa
#     Zaire,-,-,-,-                      => see Congo, Democratic Republic of the
#     Myanmar,-,-,-,-,-,-                => see Burma
#     Virgin Islands (US),-,-,-,-,-,.vi  => see Virgin Islands
#     Virgin Islands (UK),-,-,-,-,-,.vg  => see British Virgin Islands


CrossrefCodes = Struct.new(
                :name,
                :gec,
                :a2,
                :a3,
                :num,   ## note: is saved as a string w/ three digits (e.g. 042)
                :stanag,
                :internet,
                :notes)


def find_xrefcodes( html )
  recs = []
  
  page = Nokogiri::HTML( html )

  tables = page.css( 'div > table' )   ## note: must follow immediately (e.g. use >)

  tables.each do |table|
    puts "table"
    tr = table.children.filter( 'tr' )   ### use children only
    puts " tr.count: #{tr.count}"
    td = tr[0].children.filter( 'td' )  ## use children only ( -- filter required??)
    puts "  td.count: #{td.count}"
  
    td1 = td[0]
    td2 = td[1]
    td3 = td[2]   ## includes embedded table
    td4 = td[3]
    td5 = td[4]
    td6 = td[5]

    td3td = td3.css( 'table')[0].css( 'tr' )[0].css('td')   ## use all-in-one css selector ??
    td3a  = td3td[0]
    td3b  = td3td[1]
    td3c  = td3td[2]

    puts "   1 |>#{td1.css('a').text}<|"
    puts "   2 |>#{td2.text}<|"
    puts "   3a|>#{td3a.text}<|"
    puts "   3b|>#{td3b.text}<|"
    puts "   3c|>#{td3c.text}<|"
    puts "   4 |>#{td4.text}<|"
    puts "   5 |>#{td5.text}<|"
    puts "   6 |>#{td6.text}<|"

    pp td1
    
    rec = CrossrefCodes.new
    rec.name     = td1.css('a').text
    rec.gec      = td2.text
    rec.a3       = td3a.text
    rec.a2       = td3b.text
    rec.num      = td3c.text
    rec.stanag   = td4.text
    rec.internet = td5.text
    rec.notes    = td6.text.gsub("\u00A0", '')   ##  note: remove &nbsp; mapped to \u00A0 if present

    pp rec    

    recs << rec
  end

  ##pp tables.count
  recs
end



html = File.read_utf8( './xrefcodes.html' )
pp html[0..100]

recs = find_xrefcodes( html )


###
## fix/todo: (re)use from factbook utils  ??

def values_to_csv( values )
  buf = ""
  values.each_with_index do |value,i|
     buf << ','  if i > 0    ## add comma (except for first value)
     if value =~ /^[1-9][,0-9]+[0-9]$/    ### find a better regex - why? why not??
       ## check if number e.g. 17,098,242
       ##   remove commas  17098242
       buf << value.gsub( ',', '' )
     elsif value.index( ',').nil?
       ## add as is 1:1 (no commana)
       buf << value
     else
       ## escape comma with double quote
       #   e.g. Guam, The becomes "Guam, The"
       buf << '"'
       buf << value
       buf << '"'
     end
  end
  buf
end

def xrefcodes_to_csv( recs, headers )
  text = ""
  
  text << values_to_csv( headers )
  text << "\n"
  
  recs.each do |rec|
    values = [rec.name,
              rec.gec,
              rec.a3,
              rec.a2,
              rec.num,
              rec.stanag,
              rec.internet]  ## note: skip notes column for now
    text << values_to_csv( values )
    text << "\n"
  end
  
  text
end


File.open( "./xrefcodes.csv", 'w' ) do |f|
  f.write xrefcodes_to_csv( recs, ['Name', 'GEC', 'A3', 'A2', 'NUM', 'STANAG', 'INTERNET'] )
end


## print all xref codes notes
recs.each do |rec|
  unless rec.notes.empty?
    puts "#{rec.name} |>#{rec.notes}<|"
  end  
end

