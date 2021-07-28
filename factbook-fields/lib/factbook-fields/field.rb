
module Factbook


class Field
  include Logging

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


 def to_markdown
  buf = String.new('')
  buf << "**#{@title}**<br>\n"
  if data['text']
    buf << data['text']
    buf << "<br>\n"
  end

  data.each do |key,value|
    next if ['text', 'note'].include?( key )


    ## special case 1 - drop subfield key/name
    ##   Languages/Languges
    if (@title == 'Languages' && key == 'Languages') ||
       (@title == 'Exchange rates' && key == 'currency')
       # do nothing here

    ## special case 2 - data series
    ##   check for subfield series  (ending in years) e.g.
              ##     Exchange rates 2020
              ##     Exchange rates 2019
              ##     Exchange rates 2018 ...
              ##
              ##   note: allow optional 31 December 2017 too!!!!
              ##     Reserves of foreign exchange and gold 31 December 2017
              ##     Reserves of foreign exchange and gold 31 December 2016 ...
              ##
              ##  note: make case insensitive e.g.
              ##    Military Expenditures 2020  => Military expenditures
              ##
              ##   more special dates:
              ##     Debt - external 31 March 2016
              ##     Debt - external June 2010
              ##     Debt - external FY10/11
              ##     Gini Index coefficient - distribution of family income FY2011
              ##     Gini Index coefficient - distribution of family income December 2017
              ##     Inflation rate (consumer prices) January 2017
              ##     Unemployment rate April 2011

       elsif key =~ %r{^
                                      (.+?)[ ]
                                        ((
                                           (31[ ])?
                                           (December | June | January | April | March)
                                           [ ]
                                         )?
                                         \d{4}
                                          |
                                         FY(\d{4}|\d{2}/\d{2})
                                        )
                                     $}x  && @title.downcase == $1.downcase
        # do nothing here
     else  ## regular / standard case - start with subfield key/name
       buf << "_#{key}_: "
     end
    buf << value['text']
    buf << "<br>\n"
  end

  if data['note']
    buf << data['note']
    buf << "<br>\n"
  end

  buf
end



end # class Field

end # module Factbook
