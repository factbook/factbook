# encoding: utf-8

require 'csv'
require 'pp'

## fix/todo:
##   use Factbook.comparisons     for rows !!!

text = File.read( './categories.csv' )

rows = CSV.parse( text, headers: true )

pp rows

cats = rows.group_by { |row| row['Category'] }

pp cats

cats.each do |k,v|
  
  puts "### #{k}"
  puts ""
  
  v.each do |row|
    puts "- [#{row['Name']}](data/c#{row['Num']}.csv)"
  end
  
  puts ""
end

