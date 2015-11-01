# encoding: utf-8
#
#  use to run/test:
#   ruby -I ./lib script/build.rb

require 'factbook'

DB_CONFIG = {
  adapter:  'sqlite3',
  database: './factbook.db'
}

ActiveRecord::Base.logger = Logger.new( STDOUT )
ActiveRecord::Base.establish_connection( DB_CONFIG )

Factbook::CreateDb.new.up    ## create tables

importer = Factbook::Importer.new

Factbook.codes.each do |code|
  puts "Fetching #{code.code}- #{code.name}..."
  page = Factbook::Page.new( code.code )

  puts "Adding #{code.code}- #{code.name}..."
  importer.import( page )
end

puts "Done."
