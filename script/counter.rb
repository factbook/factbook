# encoding: utf-8
#
#  use to run:
#   ruby -I ./lib script/counter.rb

require 'factbook'


c = Factbook::Counter.new

##  see github.com/factbook/factbook.json   (use git clone)
json_dir = '../../factbook/factbook.json'
codes    = Factbook.codes

pages   = Factbook::JsonPageReader.new( json_dir ).read_pages( codes )
 
pages.each do |page|
  c.count( page )
end

h = c.data
pp h
    
### save to json
puts "saving a copy to categories.json for debugging"
File.open( "tmp/categories.json", 'w' ) do |f|
  f.write JSON.pretty_generate( h )
end



SKIP_CATEGORIES_LINES=<<EOS

######
### france plus 5 overseas regions/departments

##  metropolitan France
## metropolitan France - total
overseas departments
French Guiana
French Guiana - total
Guadeloupe
Guadeloupe and Martinique
Martinique
Mayotte
Reunion


###############
### more

Iles Eparses
Ile Amsterdam
Ile Amsterdam (Ile Amsterdam et Ile Saint-Paul)
Ile Amsterdam et Ile Saint-Paul
Ile Saint Paul
Ile Saint-Paul (Ile Amsterdam et Ile Saint-Paul)
Iles Crozet
Iles Kerguelen
Adelie Land
Bassas da India
Bassas da India (Iles Eparses)
Bassas da India, Europa Island, Glorioso Islands, Juan de Nova Island (Iles Eparses)
Europa Island
Europa Island (Iles Eparses)
Europa Island, Glorioso Islands, Juan de Nova Island
Europa Island and Juan de Nova Island (Iles Eparses)
Europa Island, Glorioso Islands, Juan de Nova Island (Iles Eparses)
Glorioso Islands
Glorioso Islands (Iles Eparses)
Glorioso Island (Iles Eparses)
Juan de Nova Island
Juan de Nova Island (Iles Eparses)
Tromelin Island
Tromelin Island (Iles Eparses)
Saint Helena
Ascension Island
Ascension
Tristan da Cunha
Tristan da Cunha island group
Baker Island
Baker, Howland, and Jarvis Islands
Baker, Howland, and Jarvis Islands, and Johnston Atoll
Baker, Howland, and Jarvis Islands, and Kingman Reef
Howland Island
Jarvis Island
Johnston Atoll
Johnston Atoll and Kingman Reef
Kingman Reef
Midway Islands
Midway Islands, Johnston, and Palmyra Atolls
Midway Islands and Palmyra Atoll
Palmyra Atoll
note on Palmyra Atoll
EOS

##   allow empty lines and skip comments
SKIP_CATEGORIES = SKIP_CATEGORIES_LINES.split("\n").select { |item| !(item =~ /^\s*$/ || item =~ /^\s*#/) }
    

def print_categories( data )
  data.each do |k,v|
  
    puts ""
    puts "## #{k} _(#{v[:count]})_"
    puts ""

    walk_categories( v, 1 )
  end
end

def walk_categories( data, level )
  data.each do |k,v|
    next if k == :count || k == :codes   ## skip "virtual" count entry (added for stats)
  
    ## skip (sub)country entries e.g. Baker Island, Ile Amsterdam, etc.
    next if  SKIP_CATEGORIES.include?( k )
  
    print "     " * (level-1)   if level > 1    ## add 4 spaces indents per extra level
    print "- "

    print "**"                  if level == 1    ## mark as bold 
    print k
    print "**"                  if level == 1

    print " _("
    print v[:count]
    if v[:codes]     ##  add codes if present
      print " - "
      print v[:codes]
    end   
    print ")_"

    print "\n"
 
    walk_categories( v, level+1)
  end
end



print_categories( c.data )

puts "Done."

