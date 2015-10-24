# encoding: utf-8

module Factbook


class Sect
  include LogUtils::Logging

  attr_accessor :title        ## use name instead of title - why? why not? 
  attr_accessor :subsects
  
  def initialize
    @subsects = []
  end

end # class Sect

end # module Factbook
