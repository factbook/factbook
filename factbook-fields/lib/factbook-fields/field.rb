
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


  def fix_html( html )
    ## note: escape
    ##   <.1%
    ##   <200
    ##
    html = html.gsub( /<(?=[ ]*[0-9.])/, '&lt;' )
    html = html.gsub( />(?=[ ]*[0-9.])/, '&gt;' )
    html
  end


  def to_html
    buf = String.new('')
    buf << "<h3>#{@title}</h3>"
    buf << "\n"
    if data['text']
      buf << %Q{<div class="category_data text">\n}
      buf << fix_html( data['text'] )  ## e.g. convert < to &lt; etc.
      buf << "\n"
      buf << "</div>\n"
    end

    data.each do |key,value|
      next if ['text', 'note'].include?( key )
      buf << %Q{<div class="category_data subfield text">\n}
      buf << %Q{  <span  class="subfield-name">}
      buf << fix_html( key )
      buf << ":"
      buf << "</span>\n"
      buf << fix_html( value['text'] )  ## e.g. convert < to &lt; etc.
      buf << "\n"
      buf << "</div>\n"
    end

    if data['note']
      buf << %Q{<div class="category_data note">\n}
      buf << fix_html( data['note'] )
      buf << "\n"
      buf << "</div>\n"
    end

    buf << "\n"
    buf
 end


end # class Field

end # module Factbook
