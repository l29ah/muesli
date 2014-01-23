#!/bin/bash
t=`tempfile -p muesli`
trap 'rm "$t"' EXIT
foodtable "$1" > "$t"
echo -n [
cn=0
# TODO cysteine/cystine wtf
for c in Protein 'Total lipid' 'Carbohydrate, by difference' 'Fiber, total' Potassium, Sodium, Calcium, Magnesium, Phosphorus, Iron, Iodine, Zinc, Selenium, Copper, Chromium, Manganese, Molybden Chloride Fluoride 'Vitamin A, RAE' 'Vitamin C' 'Vitamin D (' 'Vitamin E (' 'Vitamin K' Thiamin Riboflavin Niacin Pantothenic B-6 Biotin 'Folate, total' 'B-12' 'n-3[^)]*)' 'n-6 *[c,]*' Histidine Isoleucine Leucine Lysine Threonine Phenylalanine Threonine Tryptophan Valine Alanine Arginine Asparagine Aspartic Cystine Glutamic Glutamine Glycine Ornithine Proline Selenocysteine Serine Tyrosine; do
	if [[ "$cn" = 0 ]]; then
		cn=1
	else
		echo -n ',	'
	fi
	v=$(ghc -e 'let nonempty x = if x == [] then undefined else x in Text.Printf.printf "%.2e" (sum $ nonempty $ '"`sed -ne 's#.*'"$c"'[^,	]*	\(.*\)$#(\1):#p' "$t" | sed -e 's#mg#/1e3#;s#µg#/1e6#;s#g##'`[] :: Double)" 2>/dev/null)
	echo -n ${v:-idk}
done
echo ', 0]'
