# factbook Update Scripts


## Usage


### Generate all .json documents

Read all pages from (local web) cache and generate all .json documents

```
$ ruby -I ./factbook-readers/lib update/genjson.rb
```

Note:

For "local" builds e.g. saving the .json documents to the `./tmp`
change the OUT_ROOT in the script.


### Generate all .html profile pages


Read all pages from (local web) cache and generate all "chrome-less" .html documents


```
$ ruby -I ./factbook-readers/lib update/genhtml.rb
```


Note:

For "local" builds e.g. saving the .html documents to the `./tmp`
change the OUT_ROOT in the script.


