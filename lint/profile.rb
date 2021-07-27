###
#  use to run:
#   ruby lint/profile.rb


require_relative 'helper'


CATEGORY_RE = /^=[ ]*
                (?<name>[^ ].*)$/x    # e.g.  = Geography
                                      #   or  = People and Society

SUBFIELD_RE = /^-[ ]*
                 (?<name>[^ ].*)$/x   # e.g.   - total
                                      #   or   - border countries
                                      #        etc.


## check: change/rename to profile_tree or profile_hierarchy or _schema or ???? - why? why not?


## todo: add Factbook::ProfileGuideReader or such!!!
##   move to factbook-fields - why? why not?

def parse_profile_guide( txt )
  data = {}

  category = nil
  field    = nil

  txt.each_line do |line|
    ## note: line includes newline

    ## strip (optional) inline comments
    ##   todo/check: use index or such such and cut-off substring instead of regex - why? why not?
    line = line.sub( /#.*$/, '' )

    line = line.strip   # remove all leading & trainling spaces incl. newline

    next if line.empty? || line.start_with?('#')   # skip empty lines and comment lines


    if m=CATEGORY_RE.match( line )
      puts "category >#{m[:name]}<"
      category = data[ m[:name] ] = {}
    elsif m=SUBFIELD_RE.match( line )
      puts "    subfield >#{m[:name]}<"
      field << m[:name]
    else   ## assume field
      puts "  field >#{line}<"
      field = category[ line ] = []
    end
  end

  data
end




def read_profile( cty )
  json = Webcache.read( cty.data_url )
  data = JSON.parse( json )

  data = convert_cia( data )
  data
end


## known alternate field names
FIELD_ALT = {
  'Maternal mortality ratio' => 'Maternal mortality rate'
}



def lint_profile( guide, data )

  buf = String.new('')

  ## good category/field/subfield counts
  category_count = 0
  field_count    = 0
  subfield_count = 0

  category_undef_count = 0
  field_undef_count    = 0
  subfield_undef_count = 0


  data.each do |category_name,category_data|

    category_def = guide[ category_name ]
    if category_def.nil?
      category_undef_count += 1
      line =  "!! category >#{category_name}< undefined\n"
      print line; buf << line
    else
      category_count += 1
    end

      ## check fields
      category_data.each do |field_name,field_data|
         ## note: check for alternate field name mapping
         field_def = category_def ? category_def[ FIELD_ALT[ field_name ] || field_name ] : nil
         if field_def.nil?
           field_undef_count += 1
           line =  "!!   field >#{field_name}< in >#{category_name}< undefined\n"
           print line; buf << line
         else
           field_count += 1
         end


           field_data.each do |subfield_name,subfield_data|
              next if ['text', 'note'].include?( subfield_name )

              ## hack 1)
              ##   check if subfield name same as field name
              ##      Languages  => Languages
              if subfield_name == field_name
                ## puts "  skipping >#{subfield_name}< in >#{field_name}<"
                next
              end

              ## hack 2)
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

              if subfield_name =~ %r{^
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
                                     $}x  && field_name.downcase == $1.downcase
                ## puts "  skipping >#{subfield_name}< in >#{field_name}< series"
                next
              end

              if field_def && field_def.include?( subfield_name )
                 subfield_count += 1
              else
                  subfield_undef_count += 1
                  line = "!!       subfield >#{subfield_name}< in >#{category_name} / #{field_name}< undefined\n"
                  print line; buf << line
              end
          end
      end
  end

   undef_count = category_undef_count + field_undef_count + subfield_undef_count

   lines = String.new('')

   if undef_count == 0
      lines << "  OK "
   else
      lines << "     "
   end
   lines << "  #{category_count} categories, #{field_count} fields, #{subfield_count} subfields"
   lines << "\n"

   if undef_count > 0
     lines << "   !! UNDEFINED -- #{category_undef_count} categories, #{field_undef_count} fields, #{subfield_undef_count} subfields"
     lines << "\n"
    end

   print lines; buf << lines

   buf
end



txt = File.open( './lint/profile.txt', 'r:utf-8' ) { |f| f.read }
guide = parse_profile_guide( txt )
puts "guide:"
pp guide







## cc = [ 'au', 'be', 'mx']

buf = String.new('')

codes = Factbook.codes
codes.each do |cty|
  data = read_profile( cty )
  ## pp data

  puts
  puts "==> linting #{cty.code} #{cty.name} / #{cty.region} -- #{cty.category}..."

  buf << "\n"
  buf << "==> linting #{cty.code} #{cty.name} / #{cty.region} -- #{cty.category}:\n"
  buf << lint_profile( guide, data )
end


## write out report
File.open( './tmp/lint.txt', 'w:utf-8') { |f| f.write( buf ) }


puts "bye"





__END__

= People and Society

field >Maternal mortality ratio< undefined
  map field to => Maternal mortality rate    ??


= Environment

subfield >signed, but not ratified< in >Environment - international agreements< undefined
