# factbook Scripts


## Usage

### Fetch all pages

```
$ rake fetch         # fetch all pages and save copies to ./build/src
```


### Generate all .json documents

Read all pages from `./build/src` and generate all .json documents

```
$ rake json
```


Note:

For "local" builds e.g. saving the .json documents to the `./build/factbook.json`
use the debug flag e.g.:

```
$ rake json DEBUG=t
```


### Generate all .html profile pages


Read all pages from `./build/src` and generate all .html documents

```
$ rake html
```


Note:

For "local" builds e.g. saving the .html documents to the `./build/_profiles`
use the debug flag e.g.:

```
$ rake html DEBUG=t
```
