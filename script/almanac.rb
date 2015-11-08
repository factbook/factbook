# encoding: utf-8
#
#  use to run:
#   ruby -I ./lib script/almanac.rb


require 'factbook'


TEMPLATE = <<EOS

### <%= names %>

<%= page.name_long=='none' ? '\-' : page.name_long %> › <%= page.map %> -- <%= page.location %> <br>
<%= page.capital %> • <%= page.area %> • pop. <%= page.population %> 

**Languages:** <%= page.languages %>
**Major cities:** <%= page.major_cities %>
**Ethnic groups:** <%= page.ethnic_groups %>
**Religions:** <%= page.religions %>
**Independence:** <%= page.independence %>

**Internet:** `<%= page.internet %>` • <%= page.internet_users %> • <%= page.internet_users_rate %>
**Telephones - mobile:** <%= page.telephones_mobile %> • <%= page.telephones_mobile_subscriptions %> subs./100

EOS


#########################
### read all countries
###   using local json (dump) files

##  see github.com/factbook/factbook.json   (use git clone)
json_dir = '../../factbook/factbook.json'
codes    = Factbook.codes.countries
## todo: add tawain and ?? from others - why, why not??

pages   = Factbook::JsonPageReader.new( json_dir ).read_pages( codes )

almanac = Factbook::Almanac.new( pages )

## save to disk

File.open( './tmp/ALMANAC.md', 'w' ) do |f|
  f.write almanac.render( TEMPLATE )
end

puts "Done."
