# Attic - README.md

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


