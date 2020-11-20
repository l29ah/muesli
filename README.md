# muesli

A muesli calculator. Prints a recipe and its nutrition value. Brought up because i'm not much into oocalc or smth and hope to write some clever algo to sort the mix out for me.

This project aims to provide one with fullfilling and easy to make food that needs to be chewed considerably to be consumed to trigger the corresponding digestive responses in one's body. There also were ideas about making it less bland for people unused to spice-free food, but i concluded it's quite individual stuff; i found sweeteners (like aspartame and sucralose), vanillin, apple flavoring, garlic or chili powder doing the job. It consumes about $1 and 15mins per day, excluding the research, for me. I believe in dogfooding, so you can check out the recipe i'm using at the moment by hitting `./Muesli.hs l29ah`.

The current requirements are optimized for a median male. A female would need to take additional iron, at least. TODO: requirement profiles

If you found it useful, you're eating the muesli for a long time, or having any problems with it, drop me a line.

## Installation:

* install ghc and cabal
* `cabal update && cabal install ansi-terminal-0.6.3.1 fixed-vector-0.9.0.0`

## Usage:

To see the nutrient profile and the current recipe, call:


```
$ ./Muesli.hs default
```

The result will resemble this: [ansi2html'ed snapshot](http://muesli.l29ah.blasux.ru/muesli-dump.html)

# What does it look like

Raw:
![raw muesli](https://dump.bitcheese.net/files/syjinyr/a.jpeg)
Cooked:
![cooked muesli](https://dump.bitcheese.net/files/wucurif/b.jpeg)

# Sources
* [The original Soylent prototype](https://web.archive.org/web/20170305070025/http://robrhinehart.com/?p=424)
* https://www.bestpravo.com/federalnoje/bz-dokumenty/c5o/index.htm
* https://fdc.nal.usda.gov/fdc-app.html#/?query=
* https://lpi.oregonstate.edu/publications/rx-health
* Protein
  * should be 1,3-1,7g/kg body weight
    * 10.1123/ijsn.5.s1.s39
    * https://www.ncbi.nlm.nih.gov/pubmed/16779921
* Calcium
  * [Calcium Supplementation in Clinical Practice: A Review of Forms, Doses, and Indications](https://onlinelibrary.wiley.com/doi/full/10.1177/0115426507022003286)
  * [Stimulates gastric acid secretion](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1411522/)
* Potassium
  * https://www.nal.usda.gov/sites/default/files/fnic_uploads/water_full_report.pdf
* Sodium
  * https://www.nal.usda.gov/sites/default/files/fnic_uploads/water_full_report.pdf
* Chloride
  * no proper data from IOM
  * https://www.ahajournals.org/doi/full/10.1161/01.HYP.0000158264.36590.19 suggests chloride intake doesn't matter for blood pressure
* Manganese
  * Opinion of the scientific committee on food on the tolerable upper intake level of manganese 19.10.2009
    * manganese supplements are evil but no evidence of any damage from excessive intake from the food sources in diets of up to 20mg daily
  * https://discourse.soylent.com/t/have-you-asked-yourself-why-upper-limit-of-manganese-is-11mg-day/7660
  * https://lpi.oregonstate.edu/mic/minerals/manganese#toxicity
  * I got 8µg/L whole blood Mn while consuming 20.1mg Mn from oats per day
* Vitamin A
  * 1 IU = 300ng of retinol
* Vitamin K
  * green veggies
* Vitamin C
  * https://academic.oup.com/ajcn/article/69/6/1086/4714888/
* Vitamin D
  * comes from sunlight and supplements only, basically
  * quite a lot of inconclusive studies regarding cancer
  * amount
    * 1µg cholecalciferol = 40IU
    * https://www.sciencedaily.com/releases/2015/03/150317122458.htm
    * or even higher https://www.ncbi.nlm.nih.gov/m/pubmed/28768407/
    * my own experience re D3 -> 25(OH)D3: https://bnw.im/p/0DLNGK
* Biotin
  * Produced by body and generally abundant
  * https://en.wikipedia.org/wiki/Biotin_deficiency
* Chromium
  * No cases of deficiency if not on long-term i/v feeding
    * https://en.wikipedia.org/wiki/Chromium#Biological_role
* Molybdenum
  * Deficiency only on i/v feeding or in molybdenum-poor soils (northen China to Iran)
    * https://en.wikipedia.org/wiki/Molybdenum#Human_dietary_intake_and_deficiency
* Iodine
  * Salt form is unnecessary, molecular iodine is okay
    * https://www.zrtlab.com/blog/archive/guide-how-to-treat-iodine-deficiency/
    * 200µg I2 per 3L of water is 15-150 times less than used for drinking water disinfection
* Fluoride
  * Controversive
  * https://en.wikipedia.org/wiki/Fluoride_deficiency
  * No effect on bone strength
    * https://www.ncbi.nlm.nih.gov/pubmed/8897754
  * Seems to induce dental fluorosis at recommended dosages
    * https://www.ncbi.nlm.nih.gov/pubmed/2129630
  * Likely neurotoxic when present in drinking water
    * https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6923889/
    * https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3491930/
* Choline
  * synthesized by body in small amounts
  * i didn't observe the signs of deficiency myself although being low on it for like the whole life; tried refilling it with eggs for two weeks, didn't notice anything interesting
* Fats
  * Polyunsaturated fatty acids
    * The oil should be unrefined, since refining converts some PUFAs into trans-isomeres.
    * https://www.sciencedirect.com/science/article/pii/S016378271300057X
    * https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4179179/
    * n-3
      * https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4179179/
      * https://www.ncbi.nlm.nih.gov/pubmed/16841858
      * DHA
        * brain (at least early and elderly); produced in small quantites from ALA in young females only
        * especially vulnerable to peroxidation in vivo: https://www.ncbi.nlm.nih.gov/pubmed/11110863
  * Refined oil has a lower degree of peroxidation
    * https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4486537/
  * Refined oil has much more trans fats
    * https://www.scielo.br/pdf/aabc/v79n2/a15v79n2.pdf
