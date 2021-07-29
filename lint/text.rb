###
#   lint text of fields/subfields
#      check for html tags and more
#
#  use to run:
#   ruby lint/text.rb


require_relative 'helper'




def read_profile( cty )
  json = Webcache.read( cty.data_url )
  data = JSON.parse( json )

  data = convert_cia( data )
  data
end


HTML_OPEN_TAG_RE = %r{
                        <[ ]*
                           (?<name>[a-z]+)
                             ([ ]*
                               |
                              [ ]+[^>]+
                             )
                        >
                     }ix


def find_tags( text, exclude: [] )
  count = Hash.new(0)
  text.scan( HTML_OPEN_TAG_RE ) do |_|
     m = $~   ## get last (regex) match (object)
     ## puts " tag: #{m[:name]}"
     if exclude.include?( m[:name].downcase )
        ## skip / exclude - do NOt count
     else
       count[ m[:name] ] += 1
     end
  end
  count
end



def lint_text( data, exclude: [] )

  buf = String.new('')

  data.each do |category_name,category_data|

      ## check fields
      category_data.each do |field_name,field_data|

           field_data.each do |subfield_name,subfield_data|
              if ['text', 'note'].include?( subfield_name )
                text = subfield_data
                tags = find_tags( text, exclude: exclude )
                tag_count = tags.reduce(0) { |sum,(_,count)| sum+=count; sum }
                if tag_count > 0
                   lines = String.new('')
                   lines << "  ==>#{category_name} / #{field_name} - #{subfield_name}:\n"
                   lines << "  !! #{tag_count} tag(s): #{tags.inspect}\n"
                   lines << text
                   lines << "\n"
                   puts lines; buf << lines
                end
              else   ## assume subfields
                text = subfield_data['text']
                tags = find_tags( text, exclude: exclude )
                tag_count = tags.reduce(0) { |sum,(_,count)| sum+=count; sum }
                if tag_count > 0
                  lines = String.new('')
                  lines << "  ==>#{category_name} / #{field_name} / #{subfield_name} - text:\n"
                  lines << "  !! #{tag_count} tag(s): #{tags.inspect}\n"
                  lines << text
                  lines << "\n"
                  puts lines; buf << lines
               end
             end
          end
      end
  end
  buf
end




## cc = [ 'au', 'be', 'mx']

buf = String.new('')

codes = Factbook.codes
i = 0
codes.each do |cty|
  i += 1
  data = read_profile( cty )
  ## pp data

  puts
  puts "==> linting #{cty.code} #{cty.name} / #{cty.region} -- #{cty.category}..."

  buf << "\n"
  buf << "==> linting #{cty.code} #{cty.name} / #{cty.region} -- #{cty.category}:\n"
  buf << lint_text( data )

  break  if i > 2
end


## write out report
File.open( './tmp/lint_html_all.txt', 'w:utf-8') { |f| f.write( buf ) }



buf = String.new('')

i = 0
codes.each do |cty|
  i += 1
  data = read_profile( cty )
  ## pp data

  puts
  puts "==> linting #{cty.code} #{cty.name} / #{cty.region} -- #{cty.category}..."

  buf << "\n"
  buf << "==> linting #{cty.code} #{cty.name} / #{cty.region} -- #{cty.category}:\n"
  buf << lint_text( data, exclude: ['br','p','strong','em'] )

  ## break  if i > 2
end

## write out report
File.open( './tmp/lint_html.txt', 'w:utf-8') { |f| f.write( buf ) }



puts "bye"



