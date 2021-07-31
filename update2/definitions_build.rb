###
#   build field definitons page (from web cache), that is, DEFINITIONS.md
#
#  to run use
#     ruby update2/definitions_build.rb


require_relative 'helper'




def field_url( id )
  "https://www.cia.gov/the-world-factbook/fields/#{id}.json"
end

path =  "#{Factbook::Module::Fields.root}/data/fields.csv"

rows = CsvHash.read( path )

puts "#{rows.size} record(s)"


## group by category
rows_by_category = rows.group_by { |row| row['Category'] }
## pp rows_by_category



buf = String.new('')   ## dependency page buffer
buf << "# Definitions\n\n"

rows_by_category.each do |category, rows|
  buf << "## #{category}\n\n"

  rows.each do |row|
    pp row
    id = row['Num']

    url = field_url( id )
    json = Webcache.read( url )
    data = JSON.parse( json )

    field_name = data['field_name']
    field_id   = data['field_id']
    field_def  = data['definition']
    countries  = data['countries']

  puts "  #{countries.size} countries"

  if field_def && field_def.size > 0    # not-nil && non-empty string
    buf << "**#{field_name} (##{field_id})**<br>\n"
    buf << field_def
    buf << "\n\n"
  else
    ## note: definition might be nil/null or empty string !!!!
    ##   candidates are (only used by one country/entity):
=begin
 "name": "Field Listing :: Area - rankings",
  "field_name": "Area - rankings",
  "field_id": 406,
  "definition": "",
  "countries": [ {"name": "World",

{"name"=>"Field Listing :: Preliminary statement",
 "field_name"=>"Preliminary statement",
 "field_id"=>324,
 "definition"=>nil,
 "countries"=>
  [{"name"=>"European Union",

{"name"=>"Field Listing :: Geographic overview",
 "field_name"=>"Geographic overview",
 "field_id"=>275,
 "definition"=>nil,
 "countries"=>
  [{"name"=>"World",

!! skipping empty definition for field:
{"name"=>"Field Listing :: Union name",
 "field_name"=>"Union name",
 "field_id"=>297,
 "definition"=>nil,
 "countries"=>
  [{"name"=>"European Union",

{"name"=>"Field Listing :: Political structure",
 "field_name"=>"Political structure",
 "field_id"=>300,
 "definition"=>nil,
 "countries"=>
  [{"name"=>"European Union",

{"name"=>"Field Listing :: Member states",
 "field_name"=>"Member states",
 "field_id"=>303,
 "definition"=>nil,
 "countries"=>
  [{"name"=>"European Union",

{"name"=>
  "Field Listing :: Economy of the area administered by Turkish Cypriots",
 "field_name"=>"Economy of the area administered by Turkish Cypriots",
 "field_id"=>250,
 "definition"=>nil,
 "countries"=>
  [{"name"=>"Cyprus",

=end
      puts "!! skipping empty definition for field:"
      pp data
    end
  end
end


# puts "==> defs:"
# puts buf

File.open( './DEFINITIONS.md', 'w:utf-8') { |f| f.write( buf ) }

puts "bye"

