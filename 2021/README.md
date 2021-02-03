# Update 2021

## Download JSON Datasets from cia.gov

Starting in 2021 with the new website relaunch (?)
the cia.gov now offers datasets for country profiles in JSON!



## Testing Flow

Read all datasets from (local web) cache and generate all "raw" original 1:1 datasets:


```
$ yo -r ./2021/genjson.rb -f 2021/Flowfile.rb json1
#   -or-
$ yo -r ./2021/genjson.rb -f 2021/Flowfile.rb json1 DEBUG=t
```

or converted to "simplified" classic format:

```
$ yo -r ./2021/genjson.rb -f 2021/Flowfile.rb json2
#   -or-
$ yo -r ./2021/genjson.rb -f 2021/Flowfile.rb json2 DEBUG=t
```

Note:

For "local" builds e.g. saving the .json datasets to the `./tmp/json1` or `./tmp/json2`
directory use the `DEBUG=t` option.





## Todos

missing?

```
#<struct Factbook::Codes::Code
 code="wi",
 name="Western Sahara",
 category="Miscellaneous",
 region="Africa">
  sleep 1 sec(s)...
GET https://www.cia.gov/the-world-factbook/geos/wi.json...
!! ERROR - 404 Not Found:
```