#!/usr/bin/env runhaskell
{-# LANGUAGE TemplateHaskell, DataKinds, FlexibleContexts #-}
{-# OPTIONS_GHC -fno-warn-tabs #-}

module Muesli where

import Control.Exception
import Control.Monad
import Data.List
import Data.Maybe
import Data.Vector.Fixed ((!))
import qualified Data.Vector.Fixed as F
import Data.Vector.Fixed.Boxed as V
import System.Console.ANSI
import System.Console.GetOpt
import System.Environment
import Text.Printf

import Database
import DatabaseTools
import Types

fromRecipe :: Recipe -> [(Amount, Source)]
fromRecipe (Recipe a b) = a ++ b

def :: Nutrients
def = F.replicate 0

getNutrients :: Component -> Nutrients
getNutrients (Substance _ n) = n
getNutrients (Pill n) = n

isPill :: Component -> Bool
isPill (Pill _) = True
isPill _ = False

-- target daily energy value
-- TODO fix the values hardcoded elsewhere
energy :: Kcal
energy = 2000

-- Calculate the energetic value
cal :: Nutrients -> Kcal
cal x = 4 * x!0 + 9 * x!1 + 4 * x!2

amountify :: Component -> Amount -> Component
amountify (Pill x) a = Pill $ F.map (* a) x
amountify (Substance mass x) a = Substance (mass * a) $ F.map (* a) x

sumNutrients :: [(Amount, Source)] -> Nutrients
sumNutrients as = foldl (\tsum cnut -> F.zipWith (+) tsum cnut) def $ nutrientify as

nutrientify :: [(Amount, Source)] -> [Nutrients]
nutrientify as = map (\(amount, (Source _ comp)) -> getNutrients $ amountify comp amount) as

energyMultiplier :: Nutrients -> Double
energyMultiplier n = energy / (cal n)

pills :: Recipe -> [(Amount, Source)]
pills r = filter (isPill . sComponent . snd) $ rFoods r
substances :: Recipe -> [(Amount, Source)]
substances r = filter (not . isPill . sComponent . snd) $ rFoods r

normalizeRecipe :: Recipe -> Recipe
normalizeRecipe r = let	mult = energyMultiplier $ sumNutrients $ substances r in
		Recipe ((map (\(amount, source) -> (mult * amount, source)) (substances r)) ++ (pills r)) $ rSupplements r


-- daily intakes, g at 2Mcal
fdardi = mkL
	50	65	300	25
	4.7	2.4	1	0.4	1	18e-3	150e-6	15e-3	70e-6	0.7e-3	120e-6	2e-3	75e-6	3.4	nan
	0.9e-3	0.06	10e-6	15e-3	80e-6	1.5e-3	1.7e-3	20e-3	10e-3	2e-3	0.3e-3	0.4e-3	6e-6	nan	nan	nan
	nan	nan	nan	nan	nan	nan	nan	nan	nan
	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan
	nan	nan	nan	nan	nan	nan	nan
iomdrirda = mkL
	nan	nan	nan	nan
	4.7	1.5	1	0.4	0.7	15e-3	150e-6	11e-3	55e-6	0.9e-3	35e-6	2.3e-3	45e-6	2.3	4e-3
	0.9e-3	0.09	15e-6	15e-3	120e-6	1.2e-3	1.3e-3	16e-3	5e-3	1.3e-3	30e-6	0.4e-3	2.4e-6	0.55	1.6	17
	0.91	1.235	2.730	2.470	1.235	2.145	1.3	0.325	1.56
	nan	nan	nan	nan	1.235	nan	nan	nan	nan	nan	nan	nan	2.145
	nan	nan	nan	nan	nan	nan	nan
iomdriul = mkL
	nan	nan	nan	nan
	nan	2.3	2.5	0.7	4	45e-3	1.1e-3	40e-3	400e-6	10e-3	nan	11e-3	2e-3	3.6	10e-3
	3e-3	2	100e-6	1	nan	nan	nan	35e-3	nan	100e-3	nan	1e-3	nan	3.5	nan	nan
	nan	nan	nan	nan	nan	nan	nan	nan	nan
	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan
	nan	nan	nan	nan	nan	nan	nan

-- calculated for 65kg 18-29yo sedentary male 2450kcal
рсн = mkL
	59	66	292	16	-- balanced for 2000kcal
	2.5	1.3	1	0.4	0.8	10e-3	150e-6	12e-3	70e-6	1e-3	50e-6	2e-3	70e-6	2.3	4e-3
	900e-6	90e-3	10e-6	15e-3	120e-6	1.5e-3	1.8e-3	20e-3	5e-3	2e-3	50e-6	400e-6	3e-6	0.5	1.6	7
	nan	nan	nan	nan	nan	nan	nan	nan	nan
	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan
	nan	nan	nan	nan	nan	nan	nan

-- nuts:prote,	fat,	carbs,	fiber,
-- elem:potass,	sodium,	calciu,	magnes,	phosph,	iron,	iodine,	zinc,	seleni,	copper,	chromi,	mangane,molybde,chlorid,fluoride,
-- vita:a,	c,	d,	e,	k,	thiami,	ribofl,	niacin,	pantot,	b6,	biotin,	folate,	b12,	choline,omega3,	omega6,
-- e aa:His,	Ile,	Leu,	Lys,	Met,	Phe,	Thr,	Trp,	Val,
-- o aa:Ala,	Arg,	Asn,	Asp,	Cys,	Glu,	Gln,	Gly,	Orn,	Pro,	Sel,	Ser,	Tyr
-- e fa:ALA,	EPA,	DPA,	DHA,	LA,	GLA,	AA
-- the difference against iom rda
lpi = mkL
	nan	nan	nan	nan
	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan
	nan	0.4	50e-6	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan
	nan	nan	nan	nan	nan	nan	nan	nan	nan
	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan	nan
	nan	nan	nan	nan	nan	nan	nan

attenuate :: [(Amount, Source)] -> Double -> [(Amount, Source)]
attenuate l z = map (\(x, y) -> (x * z, y)) l

-- Specify the mix
-- Syntax: (
-- 	[(fraction, product)],	-- meals
-- 	[(grams, product)]	-- supplements
-- 	)
-- WARNING: supplements must not seriously affect the energy value of the mix as they're omitted from the energy calculations
fatsOilsM = [
		(0.065, sunflowerOil),
		(0.025, flaxseedOil)
	]
plantM fats bulk = [
		(0.695, bulk),
		(0.195, raisins),
		(0.02, parsleyDried)
	] ++ fats
-- TODO fix the /100 kludge
electrolytesS = [
		(5/100, naClI),
		(7/100, kCitrateH2O),
		(2/100, ca2CO3)
	]
electrolytesClS = [
		(4/100, naClI),
		(3/100, kCl),
		(2.5/100, caCl2x2H2O)
	]
pPharmaS = [
		(0.3/100, ascorbicAcid),
		(2, undevit) -- two pills
	]
myPharmaS = (3/100, fishOilCodLiver) : pPharmaS
pharmaS = (1/100, cholineBitartrate) : myPharmaS
seNutsS = (7/100, brazilNuts)
kSelenateS = (250e-6/100, kSelenate)
vigantolS = (10, vigantol) -- ten drops of vigantol on days w/o at least half an hour of good uvb light exposure
nowD3S = (1, nowD35000)
iodineS = (2e-3, iodine5p)
defaultS selenium = nowD3S : selenium : electrolytesS ++ pharmaS

simpleR bulk selenium = Recipe (plantM fatsOilsM bulk) (defaultS selenium)

l29ah :: Recipe
l29ah = Recipe
		((0.8, oat)
		:(0.15, soyflourdefatted)
		:fatsOilsM)

		(vigantolS
		:kSelenateS
		:(1, snK)
		:iodineS
		:electrolytesClS
		++pPharmaS)

recipes :: [(RecipeName, Recipe)]
recipes =
	[("l29ah-raisins", Recipe
		((0.81, oat)
		:(0.1, raisins)
		:fatsOilsM)

		(vigantolS
		:kSelenateS
		:(1, snK)
		:electrolytesClS
		++pPharmaS))
	,("l29ah", l29ah)
	,("l29ah-nosoy", Recipe
		((0.91, oat)
		:fatsOilsM)

		(vigantolS
		:kSelenateS
		:(1, snK)
		:electrolytesClS
		++pPharmaS))
	,("l29ah-choline", Recipe ((0.3, eggHardboiled) : attenuate (plantM fatsOilsM oat) 0.7) (vigantolS : kSelenateS : electrolytesClS ++ pPharmaS))
	,("default", l29ah)
	,("default-choline", simpleR oat kSelenateS)
	,("gluten-soy-free", Recipe
		((0.94, buckwheatFlakes)
		:fatsOilsM)

		(vigantolS
		:kSelenateS
		:(1, snK)
		:electrolytesClS
		++pPharmaS))
	,("gluten-free", Recipe
		((0.88, buckwheatFlakes)
		:(0.07, soyflourdefatted)
		:fatsOilsM)

		(vigantolS
		:kSelenateS
		:(1, snK)
		:electrolytesClS
		++pPharmaS))
	,("r2", Recipe (plantM fatsOilsM buckwheat) (nowD3S : kSelenateS : electrolytesClS ++ pPharmaS))
	]

references :: [Nutrients]
references = [рсн, fdardi, iomdrirda, iomdriul, lpi]

-- Compare the mix against the reference
comp :: Nutrients -> Nutrients -> Nutrients
comp p ref = F.zipWith (/) p ref

-- Compare the recipe against references
tbl :: Recipe -> [Nutrients]
tbl r = let nuts = sumNutrients $ fromRecipe r in
	nuts : map (\ref -> comp nuts ref) references

-- Some pretty-printing
printMass :: Double -> String
printMass x
	| x > 2     = printf "%4.1f  g" x
	| x > 2e-3  = printf "%4.1f mg" $ x * 1e3
	| otherwise = printf "%4.1f µg" $ x * 1e6

printPercent :: (Double -> Color) -> Double -> String
printPercent schema x
	| isNaN x = printf "       "
	| otherwise = colorify schema x (printf "%6.0f%%" x)

colorify :: (Double -> Color) -> Double -> String -> String
colorify schema x s =
		concat [
			setSGRCode [SetConsoleIntensity BoldIntensity, -- to be parseable by ansi2html and vivid in a real terminal emulator
				SetColor Foreground Dull (schema x)],
			s,
			setSGRCode [Reset]]

good x = if x < 75 then Red else if x < 125 then Yellow else Green
bad x = if x < 75 then Green else if x < 125 then Yellow else Red

report :: Recipe -> String
report rec = let [
				pr, fa, carb, fib,
				k, na, ca, mg, ph, fe, i, zn, se, cu, cr, mn, mo, cl, fl,
				vA, vC, vD, vE, vK, thi, rib, nia, pant, vB6, bio, fol, vB12, cho, o3, o6,
				his, ile, leu, lys, met, phe, thr, trp, val,
				ala, arg, asn, asp, cys, glu, gln, gly, orn, pro, sel, ser, tyr,
				alaa, epa, dpa, dha, la, gla, aa
				] = map (\(x:xs) -> x : map (* 100) xs) $ transpose $ map F.toList $ tbl rec in
	(printf "%-26s %14s %7s %7s %7s %7s %7s\n" ("" :: String) ("mass" :: String) ("РСН" :: String) ("FDA RDI" :: String) ("DRI RDA" :: String) ("LPI" :: String) ("DRI UL" :: String)) ++
	concatMap (\(a, [w, b, c, d, e, lpi]) -> printf "%-26s %14s %s %s %s %s %s\n" a (printMass w) (printPercent good b) (printPercent good c) (printPercent good d) (printPercent good lpi) (printPercent bad e)) ([
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
		("Manganese (*)", mn),
		("Molybdenum (*)", mo),
		("Chlorine", cl),
		("Fluoride (*)", fl),

		("Vitamin A", vA),
		("Vitamin C (*)", vC),
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
		("Choline", cho),
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
		("Tyrosine (b)", tyr),

		("ALA (18:3 n-3)", alaa),
		("EPA (20:5 n-3)", epa),
		("DPA (22:5 n-3)", dpa),
		("DHA (22:6 n-3)", dha),
		("LA (18:2 n-6)", la),
		("GLA (18:3 n-6)", gla),
		("AA (20:4 n-6)", aa)
		] :: [(String, [Double])]) ++
	"(*) - see README\n" ++
	"(<letter>) - specified as the sum of components in IOM RDA"

printRecipeItem :: (Amount, Source) -> String
printRecipeItem (amount, (Source name cmp)) = printf "%-26s %14s\n" name (if isPill cmp then show amount else printMass $ amount * sServingMass cmp)

printRecipe :: Recipe -> Double -> String
printRecipe r days = "Recipe for " ++ show days ++ " days:\n" ++
	(concatMap printRecipeItem  $ attenuate (fromRecipe r) days)

usage = do
	pn <- getProgName
	putStr $ usageInfo ("Usage: " ++ pn ++ " <recipe name>\navailable recipes:\n\n" ++ (unlines $ map fst $ recipes)) options

data Flag = FReport | FDays Double deriving (Eq, Show)

options :: [OptDescr Flag]
options =
	[ Option ['r']	["report"]	(NoArg	FReport)		"print the nutrients report table"
	, Option ['d']	["days"]	(ReqArg (FDays . read) "DAYS")	"print the sources' masses counted for DAYS of consumption"
	]

main = do
	args <- getArgs
	let (opts, strings, errs) = getOpt RequireOrder options args
	fromMaybe usage $ do
		recipename <- listToMaybe strings
		rec <- lookup recipename recipes
		let nrec = normalizeRecipe rec
		return $ do
			putStrLn $ report nrec
			let days = maybe 1 (\(FDays d) -> d) $ find (\x -> case x of FDays _ -> True; _ -> False) opts
			when (notElem FReport opts) $ putStrLn $ '\n' :
				(printRecipe nrec days) ++
				("\nApproximate mass: " ++ (printMass $ (days *) $ sum $ map (\(amount, (Source _ cmp)) -> if isPill cmp then amount else amount * sServingMass cmp) $ fromRecipe nrec))
