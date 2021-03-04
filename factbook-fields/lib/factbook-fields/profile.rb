
module Factbook


class Profile
  include LogUtils::Logging

  ## attr_reader :categories   ## "structured" access e.g. categories/fields/etc.
  ##   use each for access by default for categories - why? why not?

  attr_accessor :info         ##  meta info e.g. country_code, country_name, region_name, last_updated, etc.

  def initialize
    @categories = {}
    @info       = ProfileInfo.new
  end

  def add( category )
    @categories[ category.title ] = category
  end
  alias_method :<<, :add

  def [](key)  ### convenience shortcut
    @categories[key]
  end



  def to_h
    data = {}
    @categories.each do |_,category|
       data[ category.title ] = category.data
    end
    data
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
