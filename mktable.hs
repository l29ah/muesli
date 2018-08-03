#!/usr/bin/runhaskell
{-# OPTIONS_GHC -fno-warn-tabs #-}
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

lookups csv components = map (\c -> tablify $ llookup c csv) components

-- Assume idk = 0
lookupFatty csv = sum . map (read :: String -> Double) . filter (/= "idk") . lookups csv

components1 = ["Protein", "Total lipid (fat)", "Carbohydrate, by difference", "Fiber, total dietary"]
components2 = ["Potassium, K", "Sodium, Na", "Calcium, Ca", "Magnesium, Mg", "Phosphorus, P", "Iron, Fe", "Iodine, I", "Zinc, Zn", "Selenium, Se", "Copper, Cu", "Chromium, Cr", "Manganese, Mn", "Molybden, Md", "Chloride, Cl", "Fluoride, F"]
componentsPreFat = ["Vitamin A, RAE", "Vitamin C, total ascorbic acid", "Vitamin D (D2 + D3)", "Vitamin E (alpha-tocopherol)", "Vitamin K (phylloquinone)", "Thiamin", "Riboflavin", "Niacin", "Pantothenic acid", "Vitamin B-6", "Biotin", "Folate, total", "Vitamin B-12", "Choline, total"]
componentsPostFat = ["Histidine", "Isoleucine", "Leucine", "Lysine", "Threonine", "Phenylalanine", "Threonine", "Tryptophan", "Valine", "Alanine", "Arginine", "Asparagine", "Aspartic acid", "Cystine", "Glutamic acid", "Glutamine", "Glycine", "Ornithine", "Proline", "Selenocysteine", "Serine", "Tyrosine"]

omega3 = ["18:3 n-3 c,c,c (ALA)", "20:5 n-3 (EPA)", "22:5 n-3 (DPA)", "22:6 n-3 (DHA)"]
omega6 = ["18:2 n-6 c,c", "18:3 n-6 c,c,c", "20:4 n-6"]

sep = "\t"
format comp csv = intercalate sep $ lookups csv comp

main = do
	c <- getContents
	let cp = parseCSV "" c
	either
		print
		(\r -> do
			putStrLn $ format components1 r
			putStrLn $ format components2 r
			putStrLn $ (intercalate sep $ concat [
				lookups r componentsPreFat,
				[show $ lookupFatty r omega3, show $ lookupFatty r omega6]])
			putStrLn $ (intercalate sep $ lookups r componentsPostFat)
			putStrLn $ intercalate sep $ concat [
				lookups r omega3,
				lookups r omega6]
		)
		cp
