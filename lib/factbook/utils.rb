# encoding: utf-8

module Factbook
  module Utils

########################################
## todo: move to textutils - why, why not ?????

def encode_utf8( text )

  errors = []   ## also return list of encoding errors

  ## note: factbook claims utf-8  - but includes invalid bytes in some pages
  ##   encoding is likley wester/windows-

  ## note:
  ##   use �    - unknown/invalid unicode char
  ##  fix/todo: use ASCII-8BIT instead of binnary
  text = text.encode('UTF-8', 'binary', :invalid => :replace,
                                        :undef   => :replace,
                                        :replace => '�' )

  ## check for replaced/invalid chars and log warrning
  pos = text.index( '�' )
  while pos
    from = pos-10   ## tood/fix: use min/max to check for bounds - why? why not??
    to   = pos+10
    around = text[from..to]
    puts "  pos #{pos}, from #{from}, to #{to}, around >#{around}<"
    msg  = "invalid char on pos #{pos} around: >#{around}<"
    puts msg
    ## also log message / w timestamp
 
    errors << "#{Time.now} - #{msg}" 

    pos = text.index( '�', pos+1 )
  end

  [text,errors]   ## return text and errors (list)
end



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
