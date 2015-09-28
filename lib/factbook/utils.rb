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

  end   # module Utils
end     # module Factbook
