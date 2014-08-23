# factbook - scripts for the world factbook (get open structured data e.g JSON etc.)

* home  :: [github.com/worlddb/factbook.ruby](https://github.com/worlddb/factbook.ruby)
* bugs  :: [github.com/worlddb/factbook.ruby/issues](https://github.com/worlddb/factbook.ruby/issues)
* gem   :: [rubygems.org/gems/factbook](https://rubygems.org/gems/factbook)
* rdoc  :: [rubydoc.info/gems/factbook](http://rubydoc.info/gems/factbook)
* forum :: [groups.google.com/group/openmundi](https://groups.google.com/group/openmundi)



## What's the World Factbook?

The World Factbook [1][2] published by the Central Intelligence Agency (CIA)
offers free country profiles in the public domain (that is, no copyright(s), no rights reserved).

- [1] [The World Factbook](https://www.cia.gov/library/publications/the-world-factbook/)
- [2] [Wikipedia Article: The World Factbook](http://en.wikipedia.org/wiki/The_World_Factbook)


## Usage

### Get country profile page as a hash (that is, structured data e.g. nested key/values)

```ruby

page = Factbook::Page.new( 'br' )   # br is the country code for Brazil
pp page.data                        # pretty print hash

```

### Save to disk as JSON

```ruby

page = Factbook::Page.new( 'br' )
File.open( 'br.json', 'w') do |f|
  f.write page.to_json( pretty: true )
end

```


## The World Factbook Summary - 267 Entries - 195 Sovereign Countries / 2 Others / 58 Dependencies / 6 Miscellaneous / 5 Oceans / 1 World

The World Factbook includes 267 entries:


### Sovereign Countries (195)

**A**
`af` Afghanistan,
`al` Albania,
`ag` Algeria,
`an` Andorra,
`ao` Angola,
`ac` Antigua and Barbuda,
`ar` Argentina,
`am` Armenia,
`as` Australia,
`au` Austria,
`aj` Azerbaijan
**B**
`bf` The Bahamas,
Bahrain, Bangladesh, Barbados, Belarus, Belgium, Belize, Benin, Bhutan, Bolivia, Bosnia and Herzegovina, Botswana, Brazil, Brunei, Bulgaria, Burkina Faso, Burma, Burundi
**C** Cambodia,Cameroon, Canada, Cape Verde, Central African Republic, Chad, Chile, China, Colombia, Comoros, Democratic Republic of the Congo, Republic of the Congo, Costa Rica, Cote d'Ivoire, Croatia, Cuba, Cyprus, Czech Republic
**D** Denmark, Djibouti, Dominica, Dominican Republic
**E** Ecuador, Egypt, El Salvador, Equatorial Guinea, Eritrea, Estonia, Ethiopia
**F** Fiji, Finland, France
**G** Gabon, The Gambia, Georgia, Germany, Ghana, Greece, Grenada, Guatemala, Guinea, Guinea-Bissau, Guyana
**H** Haiti, Holy See, Honduras, Hungary
**I** Iceland, India, Indonesia, Iran, Iraq, Ireland, Israel, Italy
**J** Jamaica, Japan, Jordan
**K** Kazakhstan, Kenya, Kiribati, North Korea, South Korea, Kosovo, Kuwait, Kyrgyzstan
**L** Laos, Latvia, Lebanon, Lesotho, Liberia, Libya, Liechtenstein, Lithuania, Luxembourg
**M** Macedonia, Madagascar, Malawi, Malaysia, Maldives, Mali, Malta, Marshall Islands, Mauritania, Mauritius, Mexico, Federated States of Micronesia, Moldova, Monaco, Mongolia, Montenegro, Morocco, Mozambique
**N** Namibia, Nauru, Nepal, Netherlands, NZ, Nicaragua, Niger, Nigeria, Norway
**O** Oman
**P** Pakistan, Palau, Panama, Papua New Guinea, Paraguay, Peru, Philippines, Poland, Portugal
**Q** Qatar
**R** Romania, Russia, Rwanda
**S** Saint Kitts and Nevis, Saint Lucia, Saint Vincent and the Grenadines, Samoa, San Marino, Sao Tome and Principe, Saudi Arabia, Senegal, Serbia, Seychelles, Sierra Leone, Singapore, Slovakia, Slovenia, Solomon Islands, Somalia, South Africa, South Sudan, Spain, Sri Lanka, Sudan, Suriname, Swaziland, Sweden, Switzerland, Syria
**T** Tajikistan, Tanzania, Thailand, Timor-Leste, Togo, Tonga, Trinidad and Tobago, Tunisia, Turkey, Turkmenistan, Tuvalu
**U** Uganda, Ukraine, UAE, UK, US, Uruguay, Uzbekistan
**V** Vanuatu, Venezuela, Vietnam
**Y** Yemen
**Z** Zambia, Zimbabwe


### Other (2)

Taiwan, European Union

### Dependencies (58)

- Australia (6):
  Ashmore and Cartier Islands,
  Christmas Island,
  Cocos (Keeling) Islands,
  Coral Sea Islands,
  Heard Island and McDonald Islands,
  Norfolk Island

- China (2):
  Hong Kong,
  Macau

- Denmark (2):
  Faroe Islands,
  Greenland

- France (8):
  Clipperton Island,
  French Polynesia,
  French Southern and Antarctic Lands,
  New Caledonia,
  Saint Barthelemy,
  Saint Martin,
  Saint Pierre and Miquelon,
  Wallis and Futuna

- Netherlands (3):
  Aruba,
  Curacao,
  Sint Maarten

- New Zealand (3):
  Cook Islands,
  Niue,
  Tokelau

- Norway (3):
  Bouvet Island,
  Jan Mayen,
  Svalbard

- Great Britain (17):
  Akrotiri,
  Anguilla, Bermuda,
  British Indian Ocean Territory,
  British Virgin Islands,
  Cayman Islands,
  Dhekelia,
  Falkland Islands,
  Gibraltar,
  Guernsey,
  Jersey,
  Isle of Man,
  Montserrat,
  Pitcairn Islands,
  Saint Helena,
  South Georgia and the South Sandwich Islands,
  Turks and Caicos Islands

- United States (14):
  American Samoa,
  Guam,
  Navassa Island,
  Northern Mariana Islands,
  Puerto Rico,
  Virgin Islands,
  Wake Island,
  US Pacific Island Wildlife Refuges
  (Baker Island, Howland Island, Jarvis Island, Johnston Atoll, Kingman Reef, Midway Islands, Palmyra Atoll)


### Miscellaneous (6)

Antarctica,
Gaza Strip,
Paracel Islands,
Spratly Islands,
West Bank,
Western Sahara

### Oceans (5)

Arctic Ocean,
Atlantic Ocean,
Indian Ocean,
Pacific Ocean,
Southern Ocean

### World (1)

`xx` World




## Ready-To-Use Public Domain Factbook Datasets

[openmundi/factbook.json](https://github.com/openmundi/factbook.json) - open (public domain)
factbook country profiles in JSON for all the world's countries (using internet domain names
for country codes e.g. Austria is `at.json` not `au.json`, Germany is `de.json` not `gm.json` and so on)



## Alternatives (Libraries and Gems)

Ruby

- [worldfactbook gem](https://github.com/sayem/worldfactbook)
  by Sayem Khan (aka sayem);
  fetches data from its own mirror, that is, [rubyworldfactbook.com](http://rubyworldfactbook.com)
  (last updated 2011?)

- [the_country_identity gem](https://github.com/p1nox/the_country_identity)
  by Raul Pino (aka p1nox);
  fetches data from an [RDF Turtle endpoint](http://wifo5-03.informatik.uni-mannheim.de/factbook/)
  hosted by the Research Group Data and Web Science at the University of Mannheim, Germany

JavaScript

- [worldfactbook-dataset](https://github.com/twigkit/worldfactbook-dataset)
  by Richard Marr (aka richmarr); fetches data using Node.js
  (last updated 2013)

Others

TBD



## Install

Just install the gem:

    $ gem install factbook


## License

The `factbook` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [Open Mundi (world.db) Database Forum/Mailing List](http://groups.google.com/group/openmundi).
Thanks!