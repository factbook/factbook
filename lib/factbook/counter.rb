# encoding: utf-8

module Factbook

class Counter

attr_reader :data

def initialize
  @data = {}
end

def count( page )

  ## walk page data hash
  #   add nodes to data

  walk( page.data, @data )
end


private
def walk( h, hout )
   h.each do |k,v|
     if v.is_a? Hash
        hout2 =  hout[k] || { count: 0 }
        hout2[ :count ] += 1
        hout[k] = hout2        
        walk( v, hout2 )
     end
   end
end

end # class Counter

end # module Factbook
