# JSON Format in 2020

before big bang reorg using "old" page scraper to reconstruct structured data


- [ ] get country comparison to the world back - why? why not?

Old:
```
    "Population": {
      "text": "8,859,449 (July 2020 est.)",
      "country comparison to the world": 97
    },
```



New!

```
    "Military expenditures": {
      "Military Expenditures 2019": {
        "text": "1.84% of GDP (2019 est.)"
      },
      "Military Expenditures 2018": {
        "text": "1.82% of GDP (2018)"
      },
      "Military Expenditures 2017": {
        "text": "1.78% of GDP (2017)"
      },
      "Military Expenditures 2016": {
        "text": "1.79% of GDP (2016)"
      },
      "Military Expenditures 2015": {
        "text": "1.78% of GDP (2015)"
      }
    },
```

Old:

```
   "Military expenditures": {
      "text": "1.84% of GDP (2019 est.) / 1.82% of GDP (2018) / 1.78% of GDP (2017) / 1.79% of GDP (2016) / 1.78% of GDP (2015)",
      "country comparison to the world": 58
    },
```

collapse into one - why? why not?

