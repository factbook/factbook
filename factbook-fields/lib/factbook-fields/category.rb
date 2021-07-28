
module Factbook


class Category
  include Logging

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

  def to_html
     buf = String.new('')
     buf << "<h2>#{@title}</h2>"
     buf << "    <!-- #{@fields.size} field(s) -->"  ## add some (stats) comments
     buf << "\n\n"

     @fields.each do |_,field|
       buf << field.to_html
     end
     buf
  end

  def to_markdown
    buf = String.new('')
    buf << "## #{@title}\n\n"
    ## buf << "<!-- #{@fields.size} field(s) -->\n\n"  ## add some (stats) comments

    @fields.each do |_,field|
      buf << field.to_markdown
      buf << "\n"
    end
    buf
 end


end # class Category

end # module Factbook
