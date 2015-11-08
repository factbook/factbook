# encoding: utf-8
#
#  use to run:
#   ruby -I ./lib script/attributes.rb


#  e.g. prints attribute accessor shortcuts
#
#  ### Geography
#
#  - `location`  =>  Location
#  - `coords`  =>  Geographic coordinates
#  - `map`  =>  Map references
#  ...

require 'factbook'


attribs= Factbook.attributes.to_a

h = attribs.group_by { |a| a.category }

pp h

h.each do |k,v|
  puts ""
  puts "### #{k}"
  puts ""
  
  v.each do |a|
    puts "- `#{a.name}`  =>  #{a.path.join(' › ')}"
  end
end

