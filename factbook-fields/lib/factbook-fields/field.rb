
module Factbook


class Field
  include LogUtils::Logging

  attr_reader   :title        ## use name instead of title - why? why not?

  attr_accessor :data         ## hash holding data e.g. { 'text' => '...' etc. }

  def initialize( title )
    @title = title
    @data  = {}
  end

  def [](key)  ### convenience shortcut
    @data[ key ]
  end

end # class Field

end # module Factbook
