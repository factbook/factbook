
module Factbook


class Category
  include LogUtils::Logging

  attr_reader :title        ## use name instead of title - why? why not?

  def initialize( title )
    @title  = title
    @fields = {}
  end

  def add( field )
    @fields[ field.title ] = field
  end
  alias_method :<<, :add


  def [](key)  ### convenience shortcut
    @fields[ key ]
  end

  def size()   @fields.size; end



  def data   ## convert to hash
    ## todo/fix: how to know when to rebuild?
    ##   for now @data MUST be reset to nil manually
    data = {}
    @fields.each do |_,field|
      data[ field.title ] = field.data
    end
    data
  end

end # class Category

end # module Factbook
