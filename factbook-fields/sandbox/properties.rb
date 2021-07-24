###
#  to run use
#     ruby sandbox/properties.rb

$LOAD_PATH.unshift( '../factbook-codes/lib' )
$LOAD_PATH.unshift( './lib' )
require 'factbook/fields'


require 'webget'   # note: incl. webcache



codes = Factbook.codes
puts "codes (#{codes.size})"
puts

## properties count
count = {
           categories: Hash.new(0),
           fields:     Hash.new(0),
           subfields:  Hash.new(0),
}

codes.each do |cty|   ## note: use country/cty instead of code - why? why not?
  json = Webcache.read( cty.data_url )
  data = JSON.parse( json )

  print "#{data['code']} "

  data['categories'].each do |category|
    category.each { |k,v| count[ :categories ][ k ] += 1 }

    category['fields'].each do |field|
      field.each { |k,v| count[ :fields ][ k ] += 1 }

      if field['subfields']
        field['subfields'].each do |subfield|
           subfield.each { |k,v| count[ :subfields ][ k ] += 1 }
        end
      end
    end
  end
end
print "\n"


puts "properties:"
pp count


puts "bye"


__END__

## properites as of July/24, 2021

{:categories=>
  {"id"=>2891,
   "title"=>2891,
   "fields"=>2891},
 :fields=>
  {"name"=>38661,
   "field_id"=>38661,
   "comparative"=>38328,
   "content"=>38661,
   "subfields"=>16214,
   "media"=>1044,
   "value"=>10233,
   "suffix"=>9505,
   "subfield_note"=>762,
   "estimated"=>10162,
   "info_date"=>12823,
   "field_note"=>2472,
   "prefix"=>231},
 :subfields=>
  {"name"=>49098,
   "content"=>49098,
   "title"=>37468,
   "value"=>48820,
   "suffix"=>23734,
   "estimated"=>23556,
   "info_date"=>17559,
   "subfield_note"=>3476,
   "prefix"=>3614}}

