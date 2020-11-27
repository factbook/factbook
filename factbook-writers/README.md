# factbook-writers - produce your own personal world almanac




### Use shortcut attribute accessors

```ruby
pp page.background        ## same as page['Introduction']['Background']['text']
# => "Following more than three centuries..."
pp page.area              ## same as page['Geography']['Area']['total']['text']
# => "8,515,770 sq km"
pp page.area_land         ## same as page['Geography']['Area']['land']['text']
# => "8,358,140 sq km"
pp page.area_water        ## same as page['Geography']['Area']['water']['text']
# => "157,630 sq km"
pp page.area_note         ## same as page['Geography']['Area']['note']['text']
# => "includes Arquipelago de Fernando de Noronha, Atol das Rocas, ..."
pp page.area_comparative  ## same as page['Geography']['Area - comparative']['text']
# => "slightly smaller than the US"
pp page.climate           ## same as page['Geography']['Climate']['text']
# => "mostly tropical, but temperate in south"
pp page.terrain           ## same as page['Geography']['Terrain']['text']
# => "mostly flat to rolling lowlands in north; ..."
pp page.elevation_lowest  ## same as page['Geography']['Elevation extremes']['lowest point']['text']
# => "Atlantic Ocean 0 m"
pp page.elevation_highest ## same as page['Geography']['Elevation extremes']['highest point']['text']
# => "Pico da Neblina 2,994 m"
pp page.resources         ## same as page['Geography']['Natural resources']['text']
# => "bauxite, gold, iron ore, manganese, nickel, phosphates, ..."
...
```

See [`data/attributes.yml`](data/attributes.yml) for the full listing of all built-in attribute shortcut accessors.
See [Attributes](../ATTRIBUTES.md) for a quick reference listing.



