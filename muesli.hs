#!/usr/bin/runhaskell
import Control.Exception
import Data.List
import Text.Printf

sz = 57
-- Avoiding typos and other evil stuff haunting us due to the lists being used as the primary data structure
ck l = assert (length l == sz) $ 100 : l

-- Put 'nan' when the value is unspecified or irrelevant in the target daily uptakes
nan = 0/0

-- TODO a better value that taints the calculation
idk :: Double
idk = 0

-- Put 'todo' when the value is to be fetched
todo = idk

pills = map (* 100)

-- grams per 100g
-- nutrients:		[prote,	fat,	carbs,	fiber,
-- elem:potass,	sodium,	calciu,	magnes,	phosph,	iron,	iodine,	zinc,	seleni,	copper,	chromi,	mangane,molybden,chloride,fluoride,
-- vita:	a,	c,	d,	e,	k,	thiami,	ribofl,	niacin,	pantot,	b6,	biotin,	folate,	b12,	omega3,	omega6,
-- e aa:His,	Ile,	Leu,	Lys,	Met,	Phe,	Thr,	Trp,	Val,
-- o aa:Ala,	Arg,	Asn,	Asp,	Cys,	Glu,	Gln,	Gly,	Orn,	Pro,	Sel,	Ser,	Tyr,
-- misc:price)
raisins = ck		[3,	0.5,	79,	5,	-- USDA 2446
	0.773,	0.017,	0.044,	0.032,	0.097,	2.1e-3,	idk,	240e-6,	0.63e-6,328e-6,	idk,	0.29e-3,idk,	idk,	todo,
	0,	3.6e-3,	0,	120e-6,	3.5e-6,	75e-6,	166e-6,	1e-3,	93e-6,	228e-6,	idk,	3.7e-6,	0,	0,	1e-3,
	7.20e-2,	5.70e-2,	9.60e-2,8.40e-2,	7.70e-2,	6.50e-2,	7.70e-2,	5.00e-2,	8.30e-2,	1.05e-1,	4.13e-1,	idk,	1.10e-1,	1.90e-2,	1.64e-1,	idk,	8.00e-2,	idk,	2.54e-1,	idk,	7.00e-2,	1.20e-2,
	13]	-- auchan
sunflowerKernel = ck	[19,	53,	23,	11,	-- USDA 3670
	0.608,	0.24,	0.071,	0.128,	1.2,	3.7e-3,	0,	5e-3,	53e-6,	1.8e-3,	idk,	1.95e-3,idk,	idk,	todo,
	0,	0,	0,	25e-3,	0,	1.48e-3,355e-6,	8.33e-3,1.13e-3,1.34e-3,idk,	227e-6,	0,	14e-3,	12,	-- from other sources
	6.32e-1,	1.14e0,	1.66e0,	9.37e-1,	9.28e-1,1.17e0,	9.28e-1,	3.48e-1,	1.32e0,	1.12e0,	2.40e0,idk,	2.45e0,	4.51e-1,	5.58e0,	idk,	1.46e0,	idk,	1.18e0,	idk,	1.08e0,	6.66e-1,
	6.8]	-- auchan
oat = ck	-- USDA 6386
			[1.69e1,	6.90e0,	6.63e1,	1.06e1,	4.29e-1,	2.00e-3,5.40e-2,	1.77e-1,	5.23e-1,	4.72e-3,	idk,	3.97e-3,	idk,	6.26e-4,	idk,	4.92e-3,idk,	idk,	idk,	0.00e0,	idk,	0.00e0,	idk,	idk,	7.63e-4,	1.39e-4,	9.61e-4,	1.35e-3,	1.19e-4,idk,	5.60e-5,	0.00e0,	idk,	idk,	4.05e-1,	6.94e-1,	1.28e0,	7.01e-1,	5.75e-1,	8.95e-1,	5.75e-1,	2.34e-1,	9.37e-1,	8.81e-1,	1.19e0,idk,	1.45e0,	4.08e-1,	3.71e0,	idk,	8.41e-1,	idk,	9.34e-1,	idk,	7.50e-1,	5.73e-1,
	2.7]	-- auchan
parsleyDried = ck	[2.66e1,5.48e0,	5.06e1,	2.67e1,	-- USDA 254
	2.68e0,	4.52e-1,1.14e0,	4.00e-1,4.36e-1,2.20e-2,idk,	5.44e-3,1.41e-5,7.80e-4,idk,	9.81e-3,idk,	idk,	idk,
	9.70e-5,idk,	0.00e0,	8.96e-3,1.36e-3,1.96e-4,2.38e-3,9.94e-3,1.06e-3,9.00e-4,idk,	1.80e-4,0,	1.86,	1.264,	-- questionable
	7.18e-1,	1.55e0,	2.79e0,	2.10e0,	1.19e0,	1.71e0,1.19e0,	4.75e-1,	2.02e0,	1.78e0,	1.76e0,	idk,	3.17e0,2.98e-1,	3.69e0,	idk,	1.76e0,	idk,	2.01e0,	idk,	1.16e0,1.16e0,
	44]	-- auchan, 10g packs
parsley = ck		[2.97e0,7.90e-1,6.33e0,	3.30e0,	-- USDA 3092
	5.54e-1,5.60e-2,1.38e-1,5.00e-2,5.80e-2,6.20e-3,idk,	1.07e-3,1.00e-7,1.49e-4,idk,	1.60e-4,idk,	idk,	idk,
	4.21e-4,idk,	0.00e0,	7.50e-4,1.64e-3,8.60e-5,9.80e-5,1.31e-3,4.00e-4,9.00e-5,idk,	1.52e-4,0.00e0,	8e-3,	118e-3,	-- http://nutritiondata.self.com/facts/vegetables-and-vegetable-products/2513/2
	6.10e-2,	1.18e-1,	2.04e-1,	1.81e-1,	1.22e-1,	1.45e-1,	1.22e-1,	4.50e-2,1.72e-1,	1.95e-1,	1.22e-1,	idk,	2.94e-1,1.40e-2,	2.49e-1,	idk,	1.45e-1,	idk,	2.13e-1,	idk,	1.36e-1,	8.20e-2,
	40]	-- local market
flaxseedOil = ck	-- USDA 8275
			[1.10e-1,1.00e2,0.00e0,	0.00e0,
	0.00e0,	0.00e0,	1.00e-3,0.00e0,	1.00e-3,0.00e0,	idk,	7.00e-5,0.00e0,	0.00e0,	idk,	0.00e0,	idk,	idk,	idk,
	0.00e0,	idk,	0.00e0,	4.70e-4,9.30e-6,0.00e0,	0.00e0,	0.00e0,	idk,	0.00e0,	idk,	0.00e0,	0.00e0,	5.34e1,	1.43e1,
	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,
	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,
	22.4]	-- auchan, 500ml bottles

naCl = ck		[0,	0,	0,	0,
	0,	39.32,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	60.68,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	1]
naClI = ck		[0,	0,	0,	0,
	0,	39.32,	0,	0,	0,	0,	2.5e-3,	0,	0,	0,	0,	0,	0,	60.68,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	1.5]	-- auchan, 1kg packs
kCl = ck		[0,	0,	0,	0,
	52.41,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	47.6,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	35.4]	-- component-reaktiv, 500g bottles
caCl = ck		[0,	0,	0,	0,
	0,	0,	36.1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	63.9,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	36.6]	-- component-reaktiv, 500g bottles

ascorbicAcid = ck	[0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	100,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	300]
vigantol = ck		[0,	99.947,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0.0532,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	2400]
retinol = ck		[0,	96.04,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	3.96,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	1000]
aerovit = pills $ ck	[0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	2e-3,	0.1,	0,	20e-3,	0,	2e-3,	2e-3,	15e-3,	9.2e-3,	10e-3,	0,	0.2e-3,	25e-6,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	2]	-- 30 pill packs
	

-- daily intakes, g at 2Mcal
fdardi = ck		[50,	65,	300,	25,
	4.7,	2.4,	1,	0.4,	1,	18e-3,	150e-6,	15e-3,	70e-6,	0.7e-3,	120e-6,	2e-3,	75e-6,	3.4,	nan,
	0.9e-3,	0.06,	10e-6,	15e-3,	80e-6,	1.5e-3,	1.7e-3,	20e-3,	10e-3,	2e-3,	0.3e-3,	0.4e-3,	6e-6,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,
	1]
iomdrirda = ck		[nan,	nan,	nan,	nan,
	4.7,	1.5,	1,	0.4,	0.7,	15e-3,	150e-6,	11e-3,	55e-6,	0.9e-3,	35e-6,	2.3e-3,	45e-6,	2.3,	4e-3,
	0.9e-3,	0.09,	15e-6,	15e-3,	120e-6,	1.2e-3,	1.3e-3,	16e-3,	5e-3,	1.3e-3,	30e-6,	0.4e-3,	2.4e-6,	1.6,	17,
	0.91,	1.235,	2.730,	2.470,	1.235,	2.145,	1.3,	0.325,	1.56,
	nan,	nan,	nan,	nan,	1.235,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	2.145,
	1]
iomdriul = ck		[nan,	nan,	nan,	nan,
	nan,	2.3,	2.5,	0.7,	4,	45e-3,	1.1e-3,	40e-3,	400e-6,	10e-3,	nan,	11e-3,	2e-3,	3.6,	10e-3,
	3e-3,	2,	100e-6,	1,	nan,	nan,	nan,	35e-3,	nan,	100e-3,	nan,	1e-3,	nan,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,
	1]

-- calculated for 65kg 18-29yo sedentary male, 2450kcal
рсн = ck	[72,	81,	358,	20,
	2.5,	1.3,	1,	0.4,	0.8,	10e-3,	150e-6,	12e-3,	70e-6,	1e-3,	50e-6,	2e-3,	70e-6,	2.3,	4e-3,
	900e-6,	90e-3,	10e-6,	15e-3,	120e-6,	1.5e-3,	1.8e-3,	20e-3,	5e-3,	2e-3,	50e-6,	400e-6,	3e-6,	1.6,	7,
	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,
	1]


-- Specify the mix
-- Syntax: (
-- 	[(fraction, product)],	-- meals
-- 	[(grams, product)]	-- supplements
-- 	)
recipe = simpleR

plantM = [
		(0.59, oat),
		(0.19, raisins),
		(0.19, sunflowerKernel),
		(0.02, parsleyDried),
		(0.01, flaxseedOil)
	]
electrolytesS = [
		(3, naClI),
		(3, kCl),
		(2, caCl)
	]
completeR = (plantM, electrolytesS ++ [
		(0.1, ascorbicAcid),
		(0.024, vigantol), -- one drop
		(0.024, retinol) -- one drop
	])
simpleR = (plantM, electrolytesS ++ [
		(1, aerovit) -- one pill
	])

mix = map sum $ transpose $ map (\(frac, l) -> map (frac *) l) $ fst recipe

supplements p ref = comp (map sum $ transpose $ norm p :
	(map (\(grams, l) -> map ((grams / 100) *) l) $ snd recipe)) ref

-- Calculate the energetic value
cal x = 4 * x!!0 + 9 * x!!1 + 4 * x!!2

-- Normalize the mix assuming the 2Mcal diet
norm p = map (* (2000 / (cal $ tail p))) p

-- Compare the mix against the reference
comp p ref = zipWith (/) p ref

tbl = map (supplements mix) [replicate sz 1, рсн, fdardi, iomdrirda, iomdriul]

-- Some pretty-printing
report = putStr $ let [
			w, pr, fa, carb, fib,
			k, na, ca, mg, ph, fe, i, zn, se, cu, cr, mn, mo, cl, fl,
			vA, vC, vD, vE, vK, thi, rib, nia, pant, vB6, bio, fol, vB12, o3, o6,
			his, ile, leu, lys, met, phe, thr, trp, val,
			ala, arg, asn, asp, cys, glu, gln, gly, orn, pro, sel, ser, tyr,
			rur] = map (\(x:xs) -> x : map (* 100) xs) $ transpose tbl in
	(printf "%-32s %14s %7s %7s %7s %7s\n" "" "mass" "РСН" "FDA RDI" "DRI RDA" "DRI UL") ++
	printf "%-32s %13.7fg\n" "Total weight" (head w) ++
	concatMap (\(a, [w, b, c, d, e]) -> printf "%-32s %13.7fg %6.0f%% %6.0f%% %6.0f%% %6.0f%%\n" a w b c d e) [
		("Protein", pr),
		("Fat", fa),
		("Carbohydrates", carb),
		("Dietary fiber", fib),

		("Potassium", k),
		("Sodium", na),
		("Calcium", ca),
		("Magnesium", mg),
		("Phosphorus", ph),
		("Iron", fe),
		("Iodine", i),
		("Zinc", zn),
		("Selenium", se),
		("Copper", cu),
		("Chromium (*)", cr),
		("Manganese", mn),
		("Molybdenum (*)", mo),
		("Chlorine", cl),
		("Fluoride (*)", fl),

		("Vitamin A", vA),
		("Vitamin C", vC),
		("Vitamin D (*)", vD),
		("Vitamin E", vE),
		("Vitamin K", vK),
		("Thiamin", thi),
		("Riboflavin", rib),
		("Niacin", nia),
		("Pantothenic acid", pant),
		("Vitamin B6", vB6),
		("Biotin (*)", bio),
		("Folate", fol),
		("Vitamin B12", vB12),
		("Omega-3 fats", o3),
		("Omega-6 fats", o6),

		("Histidine", his),
		("Isoleucine", ile),
		("Leucine", leu),
		("Lysine", lys),
		("Methionine (a)", met),
		("Phenylalanine (b)", phe),
		("Threonine", thr),
		("Tryptophan", trp),
		("Valine", val),

		("Alanine", ala),
		("Arginine", arg),
		("Asparagine", asn),
		("Aspartic acid", asp),
		("Cysteine (a)", cys),
		("Glutamic acid", glu),
		("Glutamine", gln),
		("Glycine", gly),
		("Ornithine", orn),
		("Proline", pro),
		("Selenocysteine", sel),
		("Serine", ser),
		("Tyrosine (b)", tyr)
		] ++
	printf "%-32s %8.2f\n" "Roubles per 2MCal" (head rur) ++
	"(*) - see README\n" ++
	"(<letter>) - specified as the sum of components in IOM RDA\n"

main = report
