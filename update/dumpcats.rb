# encoding: utf-8


require 'factbook'


code = 'au'
b = Factbook::Builder.from_file( "./build/src/#{code}.html" )

## pp b.page
## pp b.page.data

sects = b.page.sects

cats = []

sects.each do |sect|
  pp sect.title
  pp sect.subsects.count
  sect.subsects.each do |subsect|
    pp subsect.title
    cats << [sect.title,subsect.title]
  end
end

pp cats


###
## fix/todo: (re)use from factbook utils  ??

def values_to_csv( values )
  buf = ""
  values.each_with_index do |value,i|
     buf << ','  if i > 0    ## add comma (except for first value)
     if value =~ /^[1-9][,0-9]+[0-9]$/    ### find a better regex - why? why not??
       ## check if number e.g. 17,098,242
       ##   remove commas  17098242
       buf << value.gsub( ',', '' )
     elsif value.index( ',').nil?
       ## add as is 1:1 (no commana)
       buf << value
     else
       ## escape comma with double quote
       #   e.g. Guam, The becomes "Guam, The"
       buf << '"'
       buf << value
       buf << '"'
     end
  end
  buf
end

def cats_to_csv( recs, headers )
  text = ""
  
  text << values_to_csv( headers )
  text << "\n"
  
  recs.each do |rec|
    values = ['']+rec+['']    ## add empty num upfront and key as last entry
    text << values_to_csv( values )
    text << "\n"
  end
  
  text
end


File.open( "./categories.csv", 'w' ) do |f|
  f.write cats_to_csv( cats, ['Num','Category','Name','Key'] )
end

