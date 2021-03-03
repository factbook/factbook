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
  pp code
end
```

resulting in:

```
#<struct Factbook::Codes::Code
 code    ="af",
 name    ="Afghanistan",
 category="Countries",
 region  ="South Asia">
#<struct Factbook::Codes::Code
 code    ="al",
 name    ="Albania",
 category="Countries",
 region  ="Europe">
#<struct Factbook::Codes::Code
 code    ="ag",
 name    ="Algeria",
 category="Countries",
 region  ="Africa">
#<struct Factbook::Codes::Code
 code    ="an",
 name    ="Andorra",
 category="Countries",
 region  ="Europe">
...
```

Note: You can filter codes by category e.g. Countries, Dependencies, Miscellaneous, Oceans, etc.
and/or by region e.g. Africa, Europe, South Asia, Central America and Caribbean, etc.


```ruby

assert_equal 261, Factbook.codes.size

## categories
assert_equal 195, Factbook.codes.countries.size
assert_equal  52, Factbook.codes.dependencies.size
assert_equal   5, Factbook.codes.oceans.size
assert_equal   1, Factbook.codes.world.size
assert_equal   2, Factbook.codes.others.size
assert_equal   6, Factbook.codes.misc.size

## regions
assert_equal  55, Factbook.codes.europe.size
assert_equal   9, Factbook.codes.south_asia.size
assert_equal   6, Factbook.codes.central_asia.size
assert_equal  22, Factbook.codes.east_n_souteast_asia.size
assert_equal  19, Factbook.codes.middle_east.size
assert_equal  56, Factbook.codes.africa.size
assert_equal   7, Factbook.codes.north_america.size
assert_equal  33, Factbook.codes.central_america_n_caribbean.size
assert_equal  14, Factbook.codes.south_america.size
assert_equal  30, Factbook.codes.australia_oceania.size
assert_equal   4, Factbook.codes.antartica.size
assert_equal   5, Factbook.codes.region('Oceans').size
assert_equal   1, Factbook.codes.region('World').size

## categories + regions
assert_equal  45, Factbook.codes.countries.europe.size
...
```

See [`data/codes.csv`](data/codes.csv) for the built-in listing of all codes with categories and regions.




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
