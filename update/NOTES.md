# Notes




##  Anno 2018

Todos - (historic) character encoding errors (in year 2018 pages)

bn - Benin //  invalidbyte sequence in UTF-8

```
[debug] fetch - copy src: https://www.cia.gov/library/publications/the-world-factbook/geos/bn.html into utf8 string
[debug] using direct net http access; no proxy configured
[debug] GET /library/publications/the-world-factbook/geos/bn.html uri=https://www.cia.gov/library/publications/the-world-factbook/geos/bn.html, redirect_limit=5
[debug] 200 OK
[debug]   content_type: text/html, content_length: 160487
rake aborted!
invalid byte sequence in UTF-8
C:/Sites/skriptbot/factbook.json/scripts/mkpage.rb:80:in `index'
C:/Sites/skriptbot/factbook.json/scripts/mkpage.rb:80:in `sanitize'

[debug] fetch - copy src: https://www.cia.gov/library/publications/the-world-factbook/geos/cg.html into utf8 string
[debug] using direct net http access; no proxy configured
[debug] GET /library/publications/the-world-factbook/geos/cg.html uri=https://www.cia.gov/library/publications/the-world-factbook/geos/cg.html, redirect_limit=5
[debug] 200 OK
[debug]   content_type: text/html, content_length: 172774
rake aborted!
invalid byte sequence in UTF-8
C:/Sites/skriptbot/factbook.json/scripts/mkpage.rb:80:in `index'
C:/Sites/skriptbot/factbook.json/scripts/mkpage.rb:80:in `sanitize'

[debug] fetch - copy src: https://www.cia.gov/library/publications/the-world-factbook/geos/lt.html into utf8 string
[debug] using direct net http access; no proxy configured
[debug] GET /library/publications/the-world-factbook/geos/lt.html uri=https://www.cia.gov/library/publications/the-world-factbook/geos/lt.html, redirect_limit=5
[debug] 200 OK
[debug]   content_type: text/html, content_length: 158329
rake aborted!
invalid byte sequence in UTF-8

[debug] fetch - copy src: https://www.cia.gov/library/publications/the-world-factbook/geos/lh.html into utf8 string
[debug] using direct net http access; no proxy configured
[debug] GET /library/publications/the-world-factbook/geos/lh.html uri=https://www.cia.gov/library/publications/the-world-factbook/geos/lh.html, redirect_limit=5
[debug] 200 OK
[debug]   content_type: text/html, content_length: 167952
rake aborted!
invalid byte sequence in UTF-8

[debug] fetch - copy src: https://www.cia.gov/library/publications/the-world-factbook/geos/pa.html into utf8 string
[debug] using direct net http access; no proxy configured
[debug] GET /library/publications/the-world-factbook/geos/pa.html uri=https://www.cia.gov/library/publications/the-world-factbook/geos/pa.html, redirect_limit=5
[debug] 200 OK
[debug]   content_type: text/html, content_length: 166740
rake aborted!
invalid byte sequence in UTF-8

[debug] fetch - copy src: https://www.cia.gov/library/publications/the-world-factbook/geos/sg.html into utf8 string
[debug] using direct net http access; no proxy configured
[debug] GET /library/publications/the-world-factbook/geos/sg.html uri=https://www.cia.gov/library/publications/the-world-factbook/geos/sg.html, redirect_limit=5
[debug] 200 OK
[debug]   content_type: text/html, content_length: 163833
rake aborted!
invalid byte sequence in UTF-8


## others
[debug] fetch - copy src: https://www.cia.gov/library/publications/the-world-factbook/geos/ee.html into utf8 string
[debug] using direct net http access; no proxy configured
[debug] GET /library/publications/the-world-factbook/geos/ee.html uri=https://www.cia.gov/library/publications/the-world-factbook/geos/ee.html, redirect_limit=5
[debug] 200 OK
[debug]   content_type: text/html, content_length: 152067
rake aborted!
invalid byte sequence in UTF-8
```

encoding errors:

```
[bn] 2015-09-26 13:04:18 +0200 - invalid char on pos 45176 around: > [Lazare S�HOU�TO]; M<
[bn] 2015-09-26 13:04:18 +0200 - invalid char on pos 45180 around: >zare S�HOU�TO]; Movem<
[cg] 2015-09-26 13:05:04 +0200 - invalid char on pos 52264 around: >Forces Arm�es de la R<
[cg] 2015-09-26 13:05:04 +0200 - invalid char on pos 52275 around: >es de la R�publique D<
[cg] 2015-09-26 13:05:04 +0200 - invalid char on pos 52286 around: >publique D�mocratique<
[lt] 2015-09-26 13:07:10 +0200 - invalid char on pos 45194 around: >[Tsebo MAT�ASA] (push<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 38796 around: >lytus, Ank�ciai, Bir�<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 38806 around: >�ciai, Bir�tono, Bir�<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 38816 around: >�tono, Bir�ai, Druski<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 38841 around: >ai, Elektr�nai, Ignal<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 38869 around: >nava, Joni�kis, Jurba<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 38889 around: >arkas, Kai�iadorys, K<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 39008 around: >inga, Kupi�kis, Lazdi<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 39039 around: >ampole, Ma�eikiai, Mo<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 39069 around: >ringa, Pag�giai, Pakr<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 39130 around: >as, Paneve�ys, Pasval<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 39169 around: >i, Radvili�kis, Rasei<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 39199 around: >tavo, Roki�kis, �akia<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 39205 around: >Roki�kis, �akiai, �al<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 39213 around: >, �akiai, �alcininkai<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 39226 around: >cininkai, �iauliu Mie<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 39243 around: > Miestas, �iauliai, �<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 39253 around: >�iauliai, �ilale, �il<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 39261 around: >, �ilale, �ilute, �ir<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 39269 around: >, �ilute, �irvintos, <
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 39289 around: > Skuodas, �vencionys,<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 39313 around: >urage, Tel�iai, Traka<
[lh] 2015-09-26 13:07:18 +0200 - invalid char on pos 39358 around: >a, Vilkavi�kis, Vilni<
[pa] 2015-09-26 13:08:33 +0200 - invalid char on pos 101277 around: > and Paran� River sys<
[sg] 2015-09-26 13:09:09 +0200 - invalid char on pos 46290 around: >ocratique �BOKK GIS G<
[th] 2015-09-26 13:09:56 +0200 - invalid char on pos 57810 around: >p d&rsquo;�tat, touri<
[uk] 2015-09-26 13:10:25 +0200 - invalid char on pos 62261 around: >rogram of �375 billio<
[ee] 2015-09-26 13:10:55 +0200 - invalid char on pos 35729 around: > is the EC�s external<
```


