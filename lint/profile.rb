###
#  use to run:
#   ruby lint/profile.rb


require_relative 'helper'



def parse_profile_guide( txt )
  data = {}

  category = nil
  field    = nil

  txt.each_line do |line|
    ## note: line includes newline
    line = line.rstrip   # remove all trainling spaces incl. newline

    next if line.empty? || line =~ /^[ ]*#/   # skip empty lines and comment lines


    if line =~ /^[ ]*=[ ]*([^ ].*)/  ## check for category e.g.  = Geography
      puts "category >#{$1}<"
      category = data[ $1 ] = {}
    elsif line =~ /^[ ]+/    ## subfield - must start with indended space
      puts "    subfield >#{line.lstrip}<"
      field << line.lstrip
    else   ## assume field
      puts "  field >#{line}<"
      field = category[ line ] = []
    end
  end

  data
end




def read_profile( code )
  codes = Factbook.codes

  cty= codes[ code ]

  json = Webcache.read( cty.data_url )
  data = JSON.parse( json )

  data = convert_cia( data )
  data
end



def lint_profile( guide, data )

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
      puts "!! category >#{category_name}< undefined"
    else
      category_count += 1
    end

      ## check fields
      category_data.each do |field_name,field_data|
         field_def = category_def ? category_def[ field_name ] : nil
         if field_def.nil?
           field_undef_count += 1
           puts "!!   field >#{field_name}< in >#{category_name}< undefined"
         else
           field_count += 1
         end


           field_data.each do |subfield_name,subfield_data|
              next if ['text', 'note'].include?( subfield_name )

              ## hack??
              ##   check for subfield series  (ending in years) e.g.
              ##     Exchange rates 2020
              ##     Exchange rates 2019
              ##     Exchange rates 2018 ...
              ##
              ##   note: allow optional 31 December 2017 too!!!!
              ##     Reserves of foreign exchange and gold 31 December 2017
              ##     Reserves of foreign exchange and gold 31 December 2016 ...

              if subfield_name =~ /^(.+?)
                                     ([ ]31[ ]December)?
                                     [ ]
                                     \d{4}$/x  && field_name == $1
                ## puts "  skipping >#{subfield_name}< in >#{field_name}< series"
                next
              end

              if field_def && field_def.include?( subfield_name )
                 subfield_count += 1
              else
                  subfield_undef_count += 1
                  puts "!!       subfield >#{subfield_name}< in >#{field_name} / #{category_name}< undefined"
              end
          end
      end
  end

   print "  #{category_count} categories, #{field_count} fields, #{subfield_count} subfields OK"
   print " -- #{category_undef_count} categories, #{field_undef_count} fields, #{subfield_undef_count} subfields UNDEFINED"
   print "\n"
end



txt = File.open( './lint/profile.txt', 'r:utf-8' ) { |f| f.read }
guide = parse_profile_guide( txt )
puts "guide:"
pp guide



data = read_profile( 'au')
pp data

lint_profile( guide, data )


puts "bye"





__END__

= People and Society

field >Maternal mortality ratio< undefined
  map field to => Maternal mortality rate    ??


= Environment

subfield >signed, but not ratified< in >Environment - international agreements< undefined
