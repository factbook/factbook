# encoding: utf-8

module Factbook


class Subsect
  include LogUtils::Logging

  attr_accessor :title        ## use name instead of title - why? why not?
  attr_accessor :data         ## hash holding data e.g. { 'text' => '...' etc. }

  def initialize
    @data = {}
  end

end # class Subsect

end # module Factbook
