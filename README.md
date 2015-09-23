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

### Options - Header, "Long" Category / Field Names

#### Include Header Option - `header: true`

```ruby
page = Factbook::Page.new( 'br', header: true )
```

will include a leading header section. Example:

```json
{
 "Header": {
   "code": "au",
   "generator": "factbook/0.1.2",
   "last_built": "2014-08-24 12:55:39 +0200"
 }
 ...
}
```

#### "Long" Category / Field Names Option - `fields: 'long'`

```ruby
page = Factbook::Page.new( 'br', fields: 'long')
```

will change the category / field names to the long form  (that is, passing through unchanged from the source).
e.g.

```ruby
page['econ']['budget_surplus_or_deficit']['text']
page['econ']['labor_force_by_occupation']['agriculture']
page['trans']['ports_and_terminals']['river_ports']
```
becomes

```ruby
page['Economy']['Budget surplus (+) or deficit (-)']['text']
page['Economy']['Labor force - by occupation']['agriculture']
page['Transportation']['Ports and terminals']['river port(s)']
```

Note: You can - of course - use the options together e.g.

```ruby
page = Factbook::Page.new( 'br', header: true, fields: 'long' )
```

or

```ruby
opts = {
  header: true,
  fields: 'long'
}
page = Factbook::Page.new( 'br', opts )
```


## The World Factbook Summary (267 Entries)

The World Factbook includes 267 entries -
195 sovereign countries /
2 others /
58 dependencies /
6 miscellaneous /
5 oceans /
1 world:


### Sovereign Countries (195)

**A**
`af` Afghanistan
`al` Albania
`ag` Algeria
`an` Andorra
`ao` Angola
`ac` Antigua and Barbuda
`ar` Argentina
`am` Armenia
`as` Australia
`au` Austria
`aj` Azerbaijan
**B**
`bf` The Bahamas
`ba` Bahrain
`bg` Bangladesh
`bb` Barbados
`bo` Belarus
`be` Belgium
`bh` Belize
`bn` Benin
`bt` Bhutan
`bl` Bolivia
`bk` Bosnia and Herzegovina
`bc` Botswana
`br` Brazil
`bx` Brunei
`bu` Bulgaria
`uv` Burkina Faso
`bm` Burma
`by` Burundi
**C**
`cb` Cambodia
`cm` Cameroon
`ca` Canada
`cv` Cape Verde
`ct` Central African Republic
`cd` Chad
`ci` Chile
`ch` China
`co` Colombia
`cn` Comoros
`cg` Congo DR
`cf` Congo
`cs` Costa Rica
`iv` Cote d'Ivoire
`hr` Croatia
`cu` Cuba
`cy` Cyprus
`ez` Czech Republic
**D**
`da` Denmark
`dj` Djibouti
`do` Dominica
`dr` Dominican Republic
**E**
`ec` Ecuador
`eg` Egypt
`es` El Salvador
`ek` Equatorial Guinea
`er` Eritrea
`en` Estonia
`et` Ethiopia
**F**
`fj` Fiji
`fi` Finland
`fr` France
**G**
`gb` Gabon
`ga` The Gambia
`gg` Georgia
`gm` Germany
`gh` Ghana
`gr` Greece
`gj` Grenada
`gt` Guatemala
`gv` Guinea
`pu` Guinea-Bissau
`gy` Guyana
**H**
`ha` Haiti
`ho` Honduras
`hu` Hungary
**I**
`ic` Iceland
`in` India
`id` Indonesia
`ir` Iran
`iz` Iraq
`ei` Ireland
`is` Israel
`it` Italy
**J**
`jm` Jamaica
`ja` Japan
`jo` Jordan
**K**
`kz` Kazakhstan
`ke` Kenya
`kr` Kiribati
`kn` North Korea
`ks` South Korea
`kv` Kosovo
`ku` Kuwait
`kg` Kyrgyzstan
**L**
`la` Laos
`lg` Latvia
`le` Lebanon
`lt` Lesotho
`li` Liberia
`ly` Libya
`ls` Liechtenstein
`lh` Lithuania
`lu` Luxembourg
**M**
`mk` Macedonia
`ma` Madagascar
`mi` Malawi
`my` Malaysia
`mv` Maldives
`ml` Mali
`mt` Malta
`rm` Marshall Islands
`mr` Mauritania
`mp` Mauritius
`mx` Mexico
`fm` Micronesia
`md` Moldova
`mn` Monaco
`mg` Mongolia
`mj` Montenegro
`mo` Morocco
`mz` Mozambique
**N**
`wa` Namibia
`nr` Nauru
`np` Nepal
`nl` Netherlands
`nz` New Zealand
`nu` Nicaragua
`ng` Niger
`ni` Nigeria
`no` Norway
**O**
`mu` Oman
**P**
`pk` Pakistan
`ps` Palau
`pm` Panama
`pp` Papua New Guinea
`pa` Paraguay
`pe` Peru
`rp` Philippines
`pl` Poland
`po` Portugal
**Q**
`qa` Qatar
**R**
`ro` Romania
`rs` Russia
`rw` Rwanda
**S**
`sc` Saint Kitts and Nevis
`st` Saint Lucia
`vc` Saint Vincent and the Grenadines
`ws` Samoa
`sm` San Marino
`tp` Sao Tome and Principe
`sa` Saudi Arabia
`sg` Senegal
`ri` Serbia
`se` Seychelles
`sl` Sierra Leone
`sn` Singapore
`lo` Slovakia
`si` Slovenia
`bp` Solomon Islands
`so` Somalia
`sf` South Africa
`od` South Sudan
`sp` Spain
`ce` Sri Lanka
`su` Sudan
`ns` Suriname
`wz` Swaziland
`sw` Sweden
`sz` Switzerland
`sy` Syria
**T**
`ti` Tajikistan
`tz` Tanzania
`th` Thailand
`tt` Timor-Leste
`to` Togo
`tn` Tonga
`td` Trinidad and Tobago
`ts` Tunisia
`tu` Turkey
`tx` Turkmenistan
`tv` Tuvalu
**U**
`ug` Uganda
`up` Ukraine
`ae` United Arab Emirates
`uk` United Kingdom
`us` United States
`uy` Uruguay
`uz` Uzbekistan
**V**
`nh` Vanuatu
`vt` Vatican City (Holy See)
`ve` Venezuela
`vm` Vietnam
**Y**
`ym` Yemen
**Z**
`za` Zambia
`zi` Zimbabwe


### Other (2)

`tw` Taiwan
`ee` European Union

### Dependencies (58)

Australia (6):
`at` Ashmore and Cartier Islands
`kt` Christmas Island
`ck` Cocos (Keeling) Islands
`cr` Coral Sea Islands
`hm` Heard Island and McDonald Islands
`nf` Norfolk Island

China (2):
`hk` Hong Kong
`mc` Macau

Denmark (2):
`fo` Faroe Islands
`gl` Greenland

France (8):
`ip` Clipperton Island
`fp` French Polynesia
`fs` French Southern and Antarctic Lands
`nc` New Caledonia
`tb` Saint Barthelemy
`rn` Saint Martin
`sb` Saint Pierre and Miquelon
`wf` Wallis and Futuna

Netherlands (3):
`aa` Aruba
`uc` Curacao
`nn` Sint Maarten

New Zealand (3):
`cw` Cook Islands
`ne` Niue
`tl` Tokelau

Norway (3):
`bv` Bouvet Island
`jn` Jan Mayen
`sv` Svalbard

Great Britain (17):
`ax` Akrotiri (Sovereign Base)
`av` Anguilla
`bd` Bermuda
`io` British Indian Ocean Territory
`vi` British Virgin Islands
`cj` Cayman Islands
`dx` Dhekelia (Sovereign Base)
`fk` Falkland Islands
`gi` Gibraltar
`gk` Guernsey
`je` Jersey
`im` Isle of Man
`mh` Montserrat
`pc` Pitcairn Islands
`sh` Saint Helena
`sx` South Georgia and the South Sandwich Islands
`tk` Turks and Caicos Islands

United States (14):
`aq` American Samoa
`gq` Guam
`bq` Navassa Island
`cq` Northern Mariana Islands
`rq` Puerto Rico
`vq` US Virgin Islands
`wq` Wake Island
`um` US Pacific Island Wildlife Refuges
(Baker Island, Howland Island, Jarvis Island, Johnston Atoll, Kingman Reef, Midway Islands, Palmyra Atoll)


### Miscellaneous (6)

`ay` Antarctica
`gz` Gaza Strip
`pf` Paracel Islands
`pg` Spratly Islands
`we` West Bank
`wi` Western Sahara

### Oceans (5)

`xq` Arctic Ocean
`zh` Atlantic Ocean
`xo` Indian Ocean
`zn` Pacific Ocean
`oo` Southern Ocean

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

Python

- [openfactbook datasets & tools](https://github.com/openfactbook)
  by Eckhard Licher; uses official (offline) download archive (last updated 2014); incl. flags, maps, and more

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
