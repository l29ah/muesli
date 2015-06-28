#!/usr/bin/runhaskell
import Data.List
import Text.CSV

llookup :: String -> [[String]] -> [String]
--llookup hx [] = ["","g","WTF " ++ hx]
llookup hx [] = []
llookup hx list = let (x:xs):ls = list in
	if x == hx then x:xs else llookup hx ls

utoe "g" = "e0"
utoe "mg" = "e-3"
utoe "µg" = "e-6"

tablify :: [String] -> String
tablify (name:unit:amount:_) = amount ++ utoe unit
tablify [] = "idk"

components = ["Protein", "Total lipid (fat)", "Carbohydrate, by difference", "Fiber, total dietary",
	"Potassium, K", "Sodium, Na", "Calcium, Ca", "Magnesium, Mg", "Phosphorus, P", "Iron, Fe", "Iodine, I", "Zinc, Zn", "Selenium, Se", "Copper, Cu", "Chromium, Cr", "Manganese, Mn", "Molybden, Md", "Chloride, Cl", "Fluoride, F",
	"Vitamin A, RAE", "Vitamin C, total ascorbic acid", "Vitamin D (D2 + D3)", "Vitamin E (alpha-tocopherol)", "Vitamin K (phylloquinone)", "Thiamin", "Riboflavin", "Niacin", "Pantothenic acid", "Vitamin B-6", "Biotin", "Folate, total", "Vitamin B-12", "Choline, total", "18:3 n-3 c,c,c (ALA)", "18:2 n-6 c,c",
	"Histidine", "Isoleucine", "Leucine", "Lysine", "Threonine", "Phenylalanine", "Threonine", "Tryptophan", "Valine", "Alanine", "Arginine", "Asparagine", "Aspartic acid", "Cystine", "Glutamic acid", "Glutamine", "Glycine", "Ornithine", "Proline", "Selenocysteine", "Serine", "Tyrosine"]

main = do
	c <- getContents
	let cp = parseCSV "" c
	either
		print
		(\r -> putStrLn $ intercalate ",\t" $ map (\c -> tablify $ llookup c r) components)
		cp
