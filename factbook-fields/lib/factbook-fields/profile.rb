
module Factbook


class Profile
  include Logging

  ## attr_reader :categories   ## "structured" access e.g. categories/fields/etc.
  ##   use each for access by default for categories - why? why not?


  def self.read( path )   ## convenience helper
    text = File.open( path, 'r:utf-8' ) { |f| f.read }
    b = ProfileBuilder.new( text )
    b.profile
  end


  def initialize
    @categories = {}
  end

  def add( category )
    @categories[ category.title ] = category
  end
  alias_method :<<, :add

  def [](key)  ### convenience shortcut
    if key.is_a?( Integer )  ## allow access by 0,1,2, etc.
      @categories.values[ key ]
    else
      @categories[key]
    end
  end

  def size()   @categories.size; end



  def to_h
    data = {}
    @categories.each do |_,category|
       data[ category.title ] = category.data
    end
    data
  end

  def to_html
    buf = String.new('')
    @categories.each do |_,category|
      buf << category.to_html
    end
    buf
  end



  def to_json( minify: false )  ## convenience helper for data.to_json; note: pretty print by default!
    if minify
      to_h.to_json
    else ## note: pretty print by default!
      JSON.pretty_generate( to_h )
    end
  end

end # class Profile
end # module Factbook
