# factbook (GitHub) Action Workflow Update Scripts


## Usage


### Generate all .json documents

Read all pages from (local web) cache and generate all .json documents

```
$ yo -r ./workflow/genjson.rb -f workflow/Flowfile.rb json
#   -or-
$ yo -r ./workflow/genjson.rb -f workflow/Flowfile.rb json DEBUG=t
```

Note:

For "local" builds e.g. saving the .json documents to the `./tmp/json`
directory use the `DEBUG=t` option.


### Generate all .html profile pages


Read all pages from (local web) cache and generate all "chrome-less" .html documents


```
$ yo -r ./workflow/genhtml.rb -f workflow/Flowfile.rb html
#   -or-
$ yo -r ./workflow/genhtml.rb -f workflow/Flowfile.rb html DEBUG=t
```


Note:

For "local" builds e.g. saving the .html documents to the `./tmp/html`
directory use the `DEBUG=t` option.

