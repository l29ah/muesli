# muesli

A muesli calculator. Brought up because i'm not much into oocalc or smth and hope to write some clever algo to sort the mix out for me.

This project aims to provide one with fullfilling and easy to make food that needs to be chewed considerably to be consumed to trigger the corresponding digestive responses in one's body. There also were ideas about making it less bland for people unused to spice-free food, but i concluded it's quite individual stuff; i found garlic and chili powder doing the job. It consumes about $1 and 15mins per day, excluding the research, for me. I believe in dogfooding, so you can check out the recipe i'm using at the moment by hitting `./muesli.hs l29ah`.

## Prerequisites:

* ghc
* ansi-terminal [available in hackage, install via cabal]

## Usage:

```
$ cabal run default
```
OR
```
$ ./muesli.hs default
```

The result resemble this:

![screenshot](https://dump.bitcheese.net/files/elekity/muesli-227aa19171c27f1e53283ca5589d9b4d5e1e4741.png)

# Sources
* http://robrhinehart.com/?p=424
* http://www.bestpravo.ru/federalnoje/bz-dokumenty/c5o.htm
* http://ndb.nal.usda.gov/ndb/search/list
* http://lpi.oregonstate.edu/mic
* Calcium
  * http://ncp.sagepub.com/content/22/3/286.long
* Potassium
  * http://www.iom.edu/Reports/2004/Dietary-Reference-Intakes-Water-Potassium-Sodium-Chloride-and-Sulfate.aspx
* Sodium
  * http://www.iom.edu/Reports/2004/Dietary-Reference-Intakes-Water-Potassium-Sodium-Chloride-and-Sulfate.aspx
* Chloride
  * http://www.iom.edu/Reports/2004/Dietary-Reference-Intakes-Water-Potassium-Sodium-Chloride-and-Sulfate.aspx
  * the upper limit can be bypassed relatively safely as it seems it only increases the blood pressure somewhat in this dose range
* Manganese
  * Opinion of the scientific committee on food on the tolerable upper intake level of manganese 19.10.2009
    * manganese supplements are evil but no evidence of any damage from excessive intake from the food sources in diets of up to 20mg daily
  * http://discourse.soylent.com/t/have-you-asked-yourself-why-upper-limit-of-manganese-is-11mg-day/7660
* Vitamin K
  * green veggies
* Vitamin C
  * http://ajcn.nutrition.org/content/69/6/1086
* Vitamin D
  * comes from sunlight and supplements only, basically
  * 1µg = 40IU
  * http://www.sciencedaily.com/releases/2015/03/150317122458.htm
  * http://www.grassrootshealth.net/garland02-11
  * http://www.ncbi.nlm.nih.gov/pmc/articles/PMC1470481/
* Biotin
  * Produced by body and generally abundant
  * https://en.wikipedia.org/wiki/Biotin_deficiency
* Chromium
  * No cases of deficiency if not on long-term i/v feeding
    * https://en.wikipedia.org/wiki/Chromium#Biological_role
* Molybdenum
  * Deficiency only on i/v feeding or in molybdenum-poor soils (northen China to Iran)
    * https://en.wikipedia.org/wiki/Molybdenum#Human_dietary_intake_and_deficiency
* Fluoride
  * Controversive
  * https://en.wikipedia.org/wiki/Fluoride_deficiency
  * No effect on bone strength
    * http://www.ncbi.nlm.nih.gov/pubmed/8897754
  * Seems to induce dental fluorosis at recommended dosages
    * http://www.ncbi.nlm.nih.gov/pubmed/2129630
* Choline
  * synthesized by body in small amounts
  * i didn't observe the signs of deficiency myself although being low on it for like the whole life; tried refilling it with eggs for two weeks, didn't notice anything interesting
* Polyunsaturated fatty acids
  * http://www.sciencedirect.com/science/article/pii/S016378271300057X
  * n-3
    * http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4179179/
    * DHA
      * brain (at least early and elderly); produced in small quantites from ALA in young females only
