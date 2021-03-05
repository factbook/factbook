
module Factbook
  module Utils


def values_to_csv( values )
  buf = ""
  values.each_with_index do |value,i|
     buf << ','  if i > 0    ## add comma (except for first value)
     ## note: allow optional $ sign e.g. $100,000,000
     ##  !!!! todo/fix: allow optional minus e.g. -44,000
     if value =~ /^\$?[1-9][,0-9]+[0-9]$/    ### find a better regex - why? why not??
       ## check if number e.g. 17,098,242  or $17,098,242
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


def data_to_csv( recs, headers )
  text = ""

  text << values_to_csv( headers )
  text << "\n"

  recs.each do |rec|
    text << values_to_csv( rec )
    text << "\n"
  end

  text
end


  end   # module Utils
end     # module Factbook
