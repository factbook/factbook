###
#  to run use
#     ruby sandbox/categories.rb

$LOAD_PATH.unshift( '../factbook-codes/lib' )
$LOAD_PATH.unshift( './lib' )
require 'factbook/fields'


require 'webget'   # note: incl. webcache



codes = Factbook.codes
puts "codes (#{codes.size})"
puts


count = {}   ## categories by count

codes.each do |cty|   ## note: use country/cty instead of code - why? why not?
  json = Webcache.read( cty.data_url )
  data = JSON.parse( json )

  code       = data['code']
  name       = data['name']
  region     = data['region']
  categories = data['categories']

  categories.each do |category|
    stat = count[ category['title']] ||= { count: 0, fields: {} }
    stat[ :count ] += 1

    category['fields'].each do |field|
      field_id          = field['field_id']
      field_name        = field['name']
      field_comparative = field['comparative']

      ### note: NOT all fields are tagged comparative!!!
      field_key = "#{field_name} (##{field_id})"

      field_stat = stat[ :fields ][ field_key ] ||= { count: 0,
                                                      comparative: 0,
                                                      name:  field_name,
                                                      id:    field_id }
      field_stat[ :count ] += 1
      field_stat[ :comparative ] +=1   if field_comparative

      if field['subfields']
        field_stat[ :subfields ] ||= { count: 0 }
        field_stat[ :subfields ][ :count ] += 1

        field['subfields'].each do |subfield|
         subfield_name =  subfield['name']

         subfield_stat = field_stat[ :subfields][ subfield_name ] ||= { count: 0 }
         subfield_stat[ :count ] += 1
       end
      end
    end
  end


  print code
  print " - "
  print name
  print " / "
  print region
  print "  =>  "
  print categories.size
  print " categories"
  print "\n"
end


puts "categories (#{count.size}):"
pp count



## generate fields.csv
##    num, category, name, comparative (true/false)
puts "Num, Category, Name"
count.each do |category_name, category|
  fields = []
  category[:fields].each do |field_key, field|
    fields << [field[:id], field[:name]]
  end

  ## sort fields by id
  fields = fields.sort {|l,r| l[0] <=> r[0] }
  ## pp fields

  fields.each do |field|
    print field[0]
    print ", "
    print category_name
    print ", "
    if field[1].include?(',')
      print %Q{"#{field[1]}"}
    else
      print field[1]
    end
    print "\n"
  end
end



puts "bye"



__END__

## categories as of July/23, 2021

categories (12):
{"Introduction"=>260,
 "Geography"=>260,
 "People and Society"=>256,
 "Environment"=>260,
 "Government"=>260,
 "Economy"=>260,
 "Energy"=>235,
 "Communications"=>249,
 "Transportation"=>260,
 "Military and Security"=>258,
 "Terrorism"=>78,
 "Transnational Issues"=>255}
