
module Factbook


class Sect
  include LogUtils::Logging

  attr_accessor :title        ## use name instead of title - why? why not?
  attr_accessor :subsects

  def initialize
    @subsects = []
  end

  def data
    ## convert sects to hash
    @data = {}

    subsects.each_with_index do |subsect,i|
      @data[ subsect.title ] = subsect.data
    end
    @data
  end


end # class Sect

end # module Factbook
