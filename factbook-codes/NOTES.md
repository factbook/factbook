# Notes


## Updates

How do (automatically) get the list of all countries ("entities") with
all codes, category (country, dependency, misc, ocean, etc.)
and region?




## Todos

- [x] add a `codes.categories` and `codes.regions` method
  to tally up all categories and regions - return just names (array)
  or names/count pairs (hash)?

- [x] add lookup by code via `[]` eg. `codes[ :bx]` or `codes[ 'bx' ]` or `codes [ 'BX' ]`

- [x] double check country names and region names from downloaded profile if match

- [ ] change region Australia-Oceania to Australia and Oceania - why? why not?

- [ ] change `Factbook.codes` to `Factbook.countries` - why? why not?

