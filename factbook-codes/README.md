# factbook-codes -  world factbook country codes (by region, by category, etc.)

* home  :: [github.com/factbook/factbook](https://github.com/factbook/factbook)
* bugs  :: [github.com/factbook/factbook/issues](https://github.com/factbook/factbook/issues)
* gem   :: [rubygems.org/gems/factbook-codes](https://rubygems.org/gems/factbook-codes)
* rdoc  :: [rubydoc.info/gems/factbook-codes](http://rubydoc.info/gems/factbook-codes)
* forum :: [groups.google.com/group/openmundi](https://groups.google.com/group/openmundi)


## What's the World Factbook?

See [factbook/factbook.json »](https://github.com/factbook/factbook.json)



## Usage

### List all codes

```ruby
Factbook.codes.each do |code|
  print code.code
  print "  "
  print "%-32s" % code.name
  print "  "
  print "%-28s" % code.category
  print "  "
  print "%-s"   % code.region
  print "\n"
end
```

resulting in:

```
af  Afghanistan                       Countries                     South Asia
al  Albania                           Countries                     Europe
ag  Algeria                           Countries                     Africa
an  Andorra                           Countries                     Europe
ao  Angola                            Countries                     Africa
ac  Antigua and Barbuda               Countries                     Central America and Caribbean
ar  Argentina                         Countries                     South America
am  Armenia                           Countries                     Middle East
as  Australia                         Countries                     Australia-Oceania
au  Austria                           Countries                     Europe
aj  Azerbaijan                        Countries                     Middle East
bf  Bahamas, The                      Countries                     Central America and Caribbean
ba  Bahrain                           Countries                     Middle East
bg  Bangladesh                        Countries                     South Asia
bb  Barbados                          Countries                     Central America and Caribbean
bo  Belarus                           Countries                     Europe
be  Belgium                           Countries                     Europe
bh  Belize                            Countries                     Central America and Caribbean
bn  Benin                             Countries                     Africa
bt  Bhutan                            Countries                     South Asia
bl  Bolivia                           Countries                     South America
bk  Bosnia and Herzegovina            Countries                     Europe
bc  Botswana                          Countries                     Africa
br  Brazil                            Countries                     South America
bx  Brunei                            Countries                     East & Southeast Asia
bu  Bulgaria                          Countries                     Europe
uv  Burkina Faso                      Countries                     Africa
bm  Burma                             Countries                     East & Southeast Asia
by  Burundi                           Countries                     Africa
cb  Cambodia                          Countries                     East & Southeast Asia
cm  Cameroon                          Countries                     Africa
ca  Canada                            Countries                     North America
cv  Cabo Verde                        Countries                     Africa
ct  Central African Republic          Countries                     Africa
cd  Chad                              Countries                     Africa
ci  Chile                             Countries                     South America
ch  China                             Countries                     East & Southeast Asia
co  Colombia                          Countries                     South America
cn  Comoros                           Countries                     Africa
cg  Congo, Democratic Republic of the  Countries                     Africa
cf  Congo, Republic of the            Countries                     Africa
cs  Costa Rica                        Countries                     Central America and Caribbean
iv  Cote d'Ivoire                     Countries                     Africa
hr  Croatia                           Countries                     Europe
cu  Cuba                              Countries                     Central America and Caribbean
cy  Cyprus                            Countries                     Europe
ez  Czech Republic                    Countries                     Europe
da  Denmark                           Countries                     Europe
dj  Djibouti                          Countries                     Africa
do  Dominica                          Countries                     Central America and Caribbean
dr  Dominican Republic                Countries                     Central America and Caribbean
ec  Ecuador                           Countries                     South America
eg  Egypt                             Countries                     Africa
es  El Salvador                       Countries                     Central America and Caribbean
ek  Equatorial Guinea                 Countries                     Africa
er  Eritrea                           Countries                     Africa
en  Estonia                           Countries                     Europe
et  Ethiopia                          Countries                     Africa
fj  Fiji                              Countries                     Australia-Oceania
fi  Finland                           Countries                     Europe
fr  France                            Countries                     Europe
gb  Gabon                             Countries                     Africa
ga  Gambia, The                       Countries                     Africa
gg  Georgia                           Countries                     Middle East
gm  Germany                           Countries                     Europe
gh  Ghana                             Countries                     Africa
gr  Greece                            Countries                     Europe
gj  Grenada                           Countries                     Central America and Caribbean
gt  Guatemala                         Countries                     Central America and Caribbean
gv  Guinea                            Countries                     Africa
pu  Guinea-Bissau                     Countries                     Africa
gy  Guyana                            Countries                     South America
ha  Haiti                             Countries                     Central America and Caribbean
ho  Honduras                          Countries                     Central America and Caribbean
hu  Hungary                           Countries                     Europe
ic  Iceland                           Countries                     Europe
in  India                             Countries                     South Asia
id  Indonesia                         Countries                     East & Southeast Asia
ir  Iran                              Countries                     Middle East
iz  Iraq                              Countries                     Middle East
ei  Ireland                           Countries                     Europe
is  Israel                            Countries                     Middle East
it  Italy                             Countries                     Europe
jm  Jamaica                           Countries                     Central America and Caribbean
ja  Japan                             Countries                     East & Southeast Asia
jo  Jordan                            Countries                     Middle East
kz  Kazakhstan                        Countries                     Central Asia
ke  Kenya                             Countries                     Africa
kr  Kiribati                          Countries                     Australia-Oceania
kn  Korea, North                      Countries                     East & Southeast Asia
ks  Korea, South                      Countries                     East & Southeast Asia
kv  Kosovo                            Countries                     Europe
ku  Kuwait                            Countries                     Middle East
kg  Kyrgyzstan                        Countries                     Central Asia
la  Laos                              Countries                     East & Southeast Asia
lg  Latvia                            Countries                     Europe
le  Lebanon                           Countries                     Middle East
lt  Lesotho                           Countries                     Africa
li  Liberia                           Countries                     Africa
ly  Libya                             Countries                     Africa
ls  Liechtenstein                     Countries                     Europe
lh  Lithuania                         Countries                     Europe
lu  Luxembourg                        Countries                     Europe
mk  Macedonia                         Countries                     Europe
ma  Madagascar                        Countries                     Africa
mi  Malawi                            Countries                     Africa
my  Malaysia                          Countries                     East & Southeast Asia
mv  Maldives                          Countries                     South Asia
ml  Mali                              Countries                     Africa
mt  Malta                             Countries                     Europe
rm  Marshall Islands                  Countries                     Australia-Oceania
mr  Mauritania                        Countries                     Africa
mp  Mauritius                         Countries                     Africa
mx  Mexico                            Countries                     North America
fm  Micronesia, Federated States of   Countries                     Australia-Oceania
md  Moldova                           Countries                     Europe
mn  Monaco                            Countries                     Europe
mg  Mongolia                          Countries                     East & Southeast Asia
mj  Montenegro                        Countries                     Europe
mo  Morocco                           Countries                     Africa
mz  Mozambique                        Countries                     Africa
wa  Namibia                           Countries                     Africa
nr  Nauru                             Countries                     Australia-Oceania
np  Nepal                             Countries                     South Asia
nl  Netherlands                       Countries                     Europe
nz  New Zealand                       Countries                     Australia-Oceania
nu  Nicaragua                         Countries                     Central America and Caribbean
ng  Niger                             Countries                     Africa
ni  Nigeria                           Countries                     Africa
no  Norway                            Countries                     Europe
mu  Oman                              Countries                     Middle East
pk  Pakistan                          Countries                     South Asia
ps  Palau                             Countries                     Australia-Oceania
pm  Panama                            Countries                     Central America and Caribbean
pp  Papua New Guinea                  Countries                     East & Southeast Asia
pa  Paraguay                          Countries                     South America
pe  Peru                              Countries                     South America
rp  Philippines                       Countries                     East & Southeast Asia
pl  Poland                            Countries                     Europe
po  Portugal                          Countries                     Europe
qa  Qatar                             Countries                     Middle East
ro  Romania                           Countries                     Europe
rs  Russia                            Countries                     Central Asia
rw  Rwanda                            Countries                     Africa
sc  Saint Kitts and Nevis             Countries                     Central America and Caribbean
st  Saint Lucia                       Countries                     Central America and Caribbean
vc  Saint Vincent and the Grenadines  Countries                     Central America and Caribbean
ws  Samoa                             Countries                     Australia-Oceania
sm  San Marino                        Countries                     Europe
tp  Sao Tome and Principe             Countries                     Africa
sa  Saudi Arabia                      Countries                     Middle East
sg  Senegal                           Countries                     Africa
ri  Serbia                            Countries                     Europe
se  Seychelles                        Countries                     Africa
sl  Sierra Leone                      Countries                     Africa
sn  Singapore                         Countries                     East & Southeast Asia
lo  Slovakia                          Countries                     Europe
si  Slovenia                          Countries                     Europe
bp  Solomon Islands                   Countries                     Australia-Oceania
so  Somalia                           Countries                     Africa
sf  South Africa                      Countries                     Africa
od  South Sudan                       Countries                     Africa
sp  Spain                             Countries                     Europe
ce  Sri Lanka                         Countries                     South Asia
su  Sudan                             Countries                     Africa
ns  Suriname                          Countries                     South America
wz  Swaziland                         Countries                     Africa
sw  Sweden                            Countries                     Europe
sz  Switzerland                       Countries                     Europe
sy  Syria                             Countries                     Middle East
ti  Tajikistan                        Countries                     Central Asia
tz  Tanzania                          Countries                     Africa
th  Thailand                          Countries                     East & Southeast Asia
tt  Timor-Leste                       Countries                     East & Southeast Asia
to  Togo                              Countries                     Africa
tn  Tonga                             Countries                     Australia-Oceania
td  Trinidad and Tobago               Countries                     Central America and Caribbean
ts  Tunisia                           Countries                     Africa
tu  Turkey                            Countries                     Middle East
tx  Turkmenistan                      Countries                     Central Asia
tv  Tuvalu                            Countries                     Australia-Oceania
ug  Uganda                            Countries                     Africa
up  Ukraine                           Countries                     Europe
ae  United Arab Emirates              Countries                     Middle East
uk  United Kingdom                    Countries                     Europe
us  United States                     Countries                     North America
uy  Uruguay                           Countries                     South America
uz  Uzbekistan                        Countries                     Central Asia
nh  Vanuatu                           Countries                     Australia-Oceania
vt  Holy See (Vatican City)           Countries                     Europe
ve  Venezuela                         Countries                     South America
vm  Vietnam                           Countries                     East & Southeast Asia
ym  Yemen                             Countries                     Middle East
za  Zambia                            Countries                     Africa
zi  Zimbabwe                          Countries                     Africa
tw  Taiwan                            Other                         East & Southeast Asia
ee  European Union                    Other                         Europe
at  Ashmore and Cartier Islands       Dependencies (Australia)      Australia-Oceania
kt  Christmas Island                  Dependencies (Australia)      Australia-Oceania
ck  Cocos (Keeling) Islands           Dependencies (Australia)      Australia-Oceania
cr  Coral Sea Islands                 Dependencies (Australia)      Australia-Oceania
hm  Heard Island and McDonald Islands  Dependencies (Australia)      Antarctica
nf  Norfolk Island                    Dependencies (Australia)      Australia-Oceania
hk  Hong Kong                         Dependencies (China)          East & Southeast Asia
mc  Macau                             Dependencies (China)          East & Southeast Asia
fo  Faroe Islands                     Dependencies (Denmark)        Europe
gl  Greenland                         Dependencies (Denmark)        North America
ip  Clipperton Island                 Dependencies (France)         North America
fp  French Polynesia                  Dependencies (France)         Australia-Oceania
fs  French Southern and Antarctic Lands  Dependencies (France)         Antarctica
nc  New Caledonia                     Dependencies (France)         Australia-Oceania
tb  Saint Barthelemy                  Dependencies (France)         Central America and Caribbean
rn  Saint Martin                      Dependencies (France)         Central America and Caribbean
sb  Saint Pierre and Miquelon         Dependencies (France)         North America
wf  Wallis and Futuna                 Dependencies (France)         Australia-Oceania
aa  Aruba                             Dependencies (Netherlands)    Central America and Caribbean
uc  Curacao                           Dependencies (Netherlands)    Central America and Caribbean
nn  Sint Maarten                      Dependencies (Netherlands)    Central America and Caribbean
cw  Cook Islands                      Dependencies (New Zealand)    Australia-Oceania
ne  Niue                              Dependencies (New Zealand)    Australia-Oceania
tl  Tokelau                           Dependencies (New Zealand)    Australia-Oceania
bv  Bouvet Island                     Dependencies (Norway)         Antarctica
jn  Jan Mayen                         Dependencies (Norway)         Europe
sv  Svalbard                          Dependencies (Norway)         Europe
ax  Akrotiri                          Dependencies (Great Britain)  Europe
av  Anguilla                          Dependencies (Great Britain)  Central America and Caribbean
bd  Bermuda                           Dependencies (Great Britain)  North America
io  British Indian Ocean Territory    Dependencies (Great Britain)  South Asia
vi  British Virgin Islands            Dependencies (Great Britain)  Central America and Caribbean
cj  Cayman Islands                    Dependencies (Great Britain)  Central America and Caribbean
dx  Dhekelia                          Dependencies (Great Britain)  Europe
fk  Falkland Islands (Islas Malvinas)  Dependencies (Great Britain)  South America
gi  Gibraltar                         Dependencies (Great Britain)  Europe
gk  Guernsey                          Dependencies (Great Britain)  Europe
je  Jersey                            Dependencies (Great Britain)  Europe
im  Isle of Man                       Dependencies (Great Britain)  Europe
mh  Montserrat                        Dependencies (Great Britain)  Central America and Caribbean
pc  Pitcairn Islands                  Dependencies (Great Britain)  Australia-Oceania
sh  Saint Helena, Ascension, and Tristan da Cunha  Dependencies (Great Britain)  Africa
sx  South Georgia and South Sandwich Islands  Dependencies (Great Britain)  South America
tk  Turks and Caicos Islands          Dependencies (Great Britain)  Central America and Caribbean
aq  American Samoa                    Dependencies (United States)  Australia-Oceania
gq  Guam                              Dependencies (United States)  Australia-Oceania
bq  Navassa Island                    Dependencies (United States)  Central America and Caribbean
cq  Northern Mariana Islands          Dependencies (United States)  Australia-Oceania
rq  Puerto Rico                       Dependencies (United States)  Central America and Caribbean
vq  Virgin Islands                    Dependencies (United States)  Central America and Caribbean
wq  Wake Island                       Dependencies (United States)  Australia-Oceania
um  United States Pacific Island Wildlife Refuges  Dependencies (United States)  Australia-Oceania
ay  Antarctica                        Miscellaneous                 Antarctica
gz  Gaza Strip                        Miscellaneous                 Middle East
pf  Paracel Islands                   Miscellaneous                 East & Southeast Asia
pg  Spratly Islands                   Miscellaneous                 East & Southeast Asia
we  West Bank                         Miscellaneous                 Middle East
xq  Arctic Ocean                      Oceans                        Oceans
zh  Atlantic Ocean                    Oceans                        Oceans
xo  Indian Ocean                      Oceans                        Oceans
zn  Pacific Ocean                     Oceans                        Oceans
oo  Southern Ocean                    Oceans                        Oceans
xx  World                             World                         World
```


Note: You can filter codes by category e.g. Countries, Dependencies, Miscellaneous, Oceans, etc.
and/or by region e.g. Africa, Europe, South Asia, Central America and Caribbean, etc.


```ruby
assert_equal 260, Factbook.codes.size

## filter by categories
assert_equal 195, Factbook.codes.countries.size
assert_equal  52, Factbook.codes.dependencies.size
assert_equal   5, Factbook.codes.misc.size
assert_equal   2, Factbook.codes.others.size
assert_equal   5, Factbook.codes.oceans.size
assert_equal   1, Factbook.codes.world.size

assert_equal  14, Factbook.codes.categories.size

## print all categories (with count)
Factbook.codes.categories
```

resulting in:

```ruby
{"Countries"                   => 195,
 "Dependencies (Great Britain)"=> 17,
 "Dependencies (France)"       => 8,
 "Dependencies (United States)"=> 8,
 "Dependencies (Australia)"    => 6,
 "Dependencies (New Zealand)"  => 3,
 "Dependencies (Netherlands)"  => 3,
 "Dependencies (Norway)"       => 3,
 "Dependencies (Denmark)"      => 2,
 "Dependencies (China)"        => 2,
 "Miscellaneous"               => 5,
 "Other"                       => 2,
 "Oceans"                      => 5,
 "World"                       => 1}
```

and

```ruby

## filter by regions
assert_equal  55, Factbook.codes.europe.size
assert_equal   9, Factbook.codes.south_asia.size
assert_equal   6, Factbook.codes.central_asia.size
assert_equal  22, Factbook.codes.east_n_souteast_asia.size
assert_equal  19, Factbook.codes.middle_east.size
assert_equal  55, Factbook.codes.africa.size
assert_equal   7, Factbook.codes.north_america.size
assert_equal  33, Factbook.codes.central_america_n_caribbean.size
assert_equal  14, Factbook.codes.south_america.size
assert_equal  30, Factbook.codes.australia_oceania.size
assert_equal   4, Factbook.codes.antartica.size
assert_equal   5, Factbook.codes.region('Oceans').size
assert_equal   1, Factbook.codes.region('World').size

## print all regions (with count)
assert_equal  13, Factbook.codes.regions.size

Factbook.codes.regions
```

resulting in:

```ruby
{"Europe"                       => 55,
 "South Asia"                   => 9,
 "Central Asia"                 => 6,
 "East & Southeast Asia"        => 22,
 "Middle East"                  => 19,
 "Africa"                       => 55,
 "North America"                => 7,
 "Central America and Caribbean"=> 33,
 "South America"                => 14,
 "Australia-Oceania"            => 30,
 "Antarctica"                   => 4,
 "Oceans"                       => 5,
 "World"                        => 1}
```

and

```ruby
## filter by categories + regions
assert_equal  45, Factbook.codes.countries.europe.size
...
```

See [`data/codes.csv`](data/codes.csv) for the built-in listing of all codes with categories and regions.








## Frequently Asked Questions (F.A.Q.s) & Answers

Q: The World Factbook front-page
says "for 266 world entities" - but
the `Factbook.codes.size` is only 260 (thus, 6 entities short)?
What's the story?

> The World Factbook provides basic intelligence on the history,
> people, government, economy, energy, geography, communications,
> transportation, military, terrorism, and transnational issues
> for 266 world entities.
>
> (Source: [`cia.gov/the-world-factbook`](https://www.cia.gov/the-world-factbook/))


A: Since March 2006
the United States Pacific Island Wildlife Refuges (`um`)
country profile consolidates
seven profiles into a single new one
(but keeps entities count as before):

- Baker Island  (`fq`)
- Howland Island (`hq`)
- Jarvis Island (`dq`)
- Johnston Atoll (`jq`)
- Kingman Reef (`kq`)
- Midway Islands (`mq`)
- Palmyra Atoll (`lq`)



Q: What happened to the Western Sahara (`wi`) country profile?

In December 2020 the World Factbook dropped coverage of the Western Sahara (`wi`). Why?
In a deal with Morocco the United States recognizes the claim
of Marocco over the Western Sahara and in return
Morocco starts official diplomatic relations with Israel.

```
Code, Name,           Category,      Region
wi,   Western Sahara, Miscellaneous, Africa
```




## Install

Use

    gem install factbook-codes

or add to your Gemfile

    gem 'factbook-codes'



## License

The `factbook` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [Open Mundi (world.db) Database Forum/Mailing List](http://groups.google.com/group/openmundi).
Thanks!
