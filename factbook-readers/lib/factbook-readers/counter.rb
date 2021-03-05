
module Factbook

class Counter

attr_reader :data

def initialize
  @data = {}
end

def count( code, page )

  ## walk page data hash
  #   add nodes to data

  walk( code, page.to_h, @data )
end


private
def walk( code, hin, hout )
   hin.each do |k,v|
     if v.is_a?( Hash )
        hout2 =  hout[k] ||= { count: 0, codes: '' }

        hout2[ :count ] += 1

        ## delete codes if larger (treshhold) than x (e.g. 9)
        hout2.delete( :codes )    if hout2[ :count ] > 9

        codes = hout2[ :codes ]
        if codes    ## note: might got deleted if passed treshhold (e.g. 9 entries)
          codes << ' '  unless codes.empty?   ## add separator (space for now)
          codes << code
          hout2[ :codes ] = codes
        end
        walk( code, v, hout2 )
     end
   end
end

end # class Counter

end # module Factbook
