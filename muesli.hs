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
-- elem:potass,	sodium,	calciu,	magnes,	phosph,	iron,	iodine,	zinc,	seleni,	copper,	chromi,	mangane,molybde,chlorid,fluoride,
-- vita:a,	c,	d,	e,	k,	thiami,	ribofl,	niacin,	pantot,	b6,	biotin,	folate,	b12,	omega3,	omega6,
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
	6.32e-1,1.14e0,	1.66e0,	9.37e-1,9.28e-1,1.17e0,	9.28e-1,3.48e-1,1.32e0,	1.12e0,	2.40e0,	idk,	2.45e0,	4.51e-1,5.58e0,	idk,	1.46e0,	idk,	1.18e0,	idk,	1.08e0,	6.66e-1,
	6.8]	-- auchan
sunflowerOil = ck	-- USDA 650
			[0.00e0,1.00e2,	0.00e0,	0.00e0,
	0.00e0,	0.00e0,	0.00e0,	0.00e0,	0.00e0,	0.00e0,	idk,	0.00e0,	0.00e0,	0.00e0,	idk,	idk,	idk,	idk,	idk,
	0.00e0,	idk,	0.00e0,	4.11e-2,5.40e-6,0.00e0,	0.00e0,	0.00e0,	0.00e0,	0.00e0,	idk,	0.00e0,	0,	0.00e0,	50,
	0.00e0,	0.00e0,	0.00e0,	0.00e0,	0.00e0,	0.00e0,	0.00e0,	0.00e0,	0.00e0,	0.00e0,	0.00e0,	idk,	0.00e0,	0.00e0,	0.00e0,	idk,	0.00e0,	idk,	0.00e0,	idk,	0.00e0,	0.00e0,
	4]	-- auchan
brazilNuts = ck	-- USDA 3685
	[1.43e1,	6.64e1,	1.23e1,	7.50e0,	6.59e-1,	3.00e-3,	1.60e-1,3.76e-1,	7.25e-1,	2.43e-3,	idk,	4.06e-3,	1.92e-3,1.74e-3,	idk,	1.22e-3,	idk,	idk,	idk,	0.00e0,	idk,	0.00e0,	5.73e-3,	0.00e0,	6.17e-4,	3.50e-5,	2.95e-4,	1.84e-4,	1.01e-4,	idk,	2.20e-5,	0.00e0,	1.70e-2,	1.70e-2,3.86e-1,	5.16e-1,	1.16e0,	4.92e-1,	3.62e-1,	6.30e-1,3.62e-1,	1.41e-1,	7.56e-1,	5.77e-1,	2.15e0,	idk,	1.35e0,	3.67e-1,	3.15e0,	idk,	7.18e-1,	idk,	6.57e-1,	idk,	6.83e-1,	4.20e-1,
	64]	-- auchan
oat = ck	-- USDA 6386
			[1.69e1,	6.90e0,	6.63e1,
	1.06e1,	4.29e-1,2.00e-3,5.40e-2,1.77e-1,5.23e-1,	4.72e-3,	idk,	3.97e-3,	idk,	6.26e-4,	idk,	4.92e-3,idk,	idk,	idk,	0.00e0,	idk,	0.00e0,	idk,	idk,	7.63e-4,	1.39e-4,	9.61e-4,	1.35e-3,	1.19e-4,idk,	5.60e-5,	0.00e0,	idk,	idk,	4.05e-1,	6.94e-1,	1.28e0,	7.01e-1,	5.75e-1,	8.95e-1,	5.75e-1,	2.34e-1,	9.37e-1,	8.81e-1,	1.19e0,idk,	1.45e0,	4.08e-1,	3.71e0,	idk,	8.41e-1,	idk,	9.34e-1,	idk,	7.50e-1,	5.73e-1,
	2.7]	-- auchan
buckwheat = ck	-- USDA 6358
			[1.32e1,	3.40e0,	7.15e1,	1.00e1,	4.60e-1,	1.00e-3,	1.80e-2,	2.31e-1,	3.47e-1,	2.20e-3,	idk,	2.40e-3,	8.30e-6,	1.10e-3,	idk,	1.30e-3,	idk,	idk,	idk,	0.00e0,	idk,	0.00e0,	idk,	idk,	1.01e-4,	4.25e-4,	7.02e-3,	1.23e-3,	2.10e-4,	idk,	3.00e-5,	0.00e0,	0.00e0,	idk,	3.09e-1,	4.98e-1,	8.32e-1,	6.72e-1,	5.06e-1,	5.20e-1,	5.06e-1,	1.92e-1,	6.78e-1,	7.48e-1,	9.82e-1,	idk,	1.13e0,	2.29e-1,	2.05e0,	idk,	1.03e0,	idk,5.07e-1,	idk,	6.85e-1,	2.41e-1,
	5]
rice = ck	-- USDA 6504
			[6.61e0,	5.80e-1,	7.93e1,	idk,	8.60e-2,	1.00e-3,	9.00e-3,	3.50e-2,	1.08e-1,	8.00e-4,	idk,	1.16e-3,	idk,	1.10e-4,	idk,	1.10e-3,	idk,	idk,	idk,	idk,	idk,	0.00e0,	idk,	idk,	7.00e-5,	4.80e-5,	1.60e-3,	1.34e-3,	1.45e-4,	idk,	9.00e-6,	0.00e0,	idk,	idk,	1.55e-1,	2.85e-1,	5.46e-1,	2.39e-1,	2.36e-1,	3.53e-1,	2.36e-1,	7.70e-2,	4.03e-1,	3.83e-1,	5.51e-1,	idk,	6.21e-1,	1.35e-1,	1.29e0,	idk,	3.01e-1,	idk,	3.11e-1,	idk,	3.47e-1,	2.21e-1,
	0]
millet = ck	-- USDA 6379
			[1.10e1,	4.22e0,	7.28e1,	8.50e0,	1.95e-1,	5.00e-3,	8.00e-3,	1.14e-1,	2.85e-1,	3.01e-3,	idk,	1.68e-3,	2.70e-6,	7.50e-4,	idk,	1.63e-3,	idk,	idk,	idk,	0.00e0,	idk,	0.00e0,	5.00e-5,	9.00e-7,	4.21e-4,	2.90e-4,	4.72e-3,	8.48e-4,	3.84e-4,	idk,	8.50e-5,	0.00e0,	idk,	idk,2.36e-1,	4.65e-1,	1.40e0,	2.12e-1,	3.53e-1,	5.80e-1,	3.53e-1,	1.19e-1,	5.78e-1,	9.86e-1,	3.82e-1,	idk,	7.26e-1,	2.12e-1,	2.40e0,	idk,	2.87e-1,	idk,	8.77e-1,	idk,	6.44e-1,	3.40e-1, 0]
parsley = ck		[2.97e0,7.90e-1,6.33e0,	3.30e0,	-- USDA 3092
	5.54e-1,5.60e-2,1.38e-1,5.00e-2,5.80e-2,6.20e-3,idk,	1.07e-3,1.00e-7,1.49e-4,idk,	1.60e-4,idk,	idk,	idk,
	4.21e-4,idk,	0.00e0,	7.50e-4,1.64e-3,8.60e-5,9.80e-5,1.31e-3,4.00e-4,9.00e-5,idk,	1.52e-4,0.00e0,	8e-3,	118e-3,	-- http://nutritiondata.self.com/facts/vegetables-and-vegetable-products/2513/2
	6.10e-2,	1.18e-1,	2.04e-1,	1.81e-1,	1.22e-1,	1.45e-1,	1.22e-1,	4.50e-2,1.72e-1,	1.95e-1,	1.22e-1,	idk,	2.94e-1,1.40e-2,	2.49e-1,	idk,	1.45e-1,	idk,	2.13e-1,	idk,	1.36e-1,	8.20e-2,
	40]	-- local market
parsleyDried = ck	[2.66e1,5.48e0,	5.06e1,	2.67e1,	-- USDA 254
	2.68e0,	4.52e-1,1.14e0,	4.00e-1,4.36e-1,2.20e-2,idk,	5.44e-3,1.41e-5,7.80e-4,idk,	9.81e-3,idk,	idk,	idk,
	9.70e-5,idk,	0.00e0,	8.96e-3,1.36e-3,1.96e-4,2.38e-3,9.94e-3,1.06e-3,9.00e-4,idk,	1.80e-4,0,	1.86,	1.264,	-- questionable
	7.18e-1,	1.55e0,	2.79e0,	2.10e0,	1.19e0,	1.71e0,1.19e0,	4.75e-1,	2.02e0,	1.78e0,	1.76e0,	idk,	3.17e0,2.98e-1,	3.69e0,	idk,	1.76e0,	idk,	2.01e0,	idk,	1.16e0,1.16e0,
	44]	-- auchan, 10g packs
flaxseed = ck	-- USDA 3757, modified using data from 8275
			[1.83e1,4.22e1,	2.89e1,	2.73e1,
	8.13e-1,3.00e-2,2.55e-1,3.92e-1,6.42e-1,5.73e-3,idk,	4.34e-3,2.54e-5,1.22e-3,idk,	2.48e-3,idk,	idk,	idk,
	0.00e0,	idk,	0.00e0,	3.10e-4,4.30e-6,1.64e-3,1.61e-4,3.08e-3,9.85e-4,4.73e-4,idk,	8.70e-5,0.00e0,	22.813,	7.00e-3,
	4.72e-1,8.96e-1,1.24e0,	8.62e-1,7.66e-1,9.57e-1,7.66e-1,2.97e-1,1.07e0,
	9.25e-1,1.92e0,	idk,	2.05e0,3.40e-1,	4.04e0,	idk,	1.25e0,	idk,	8.06e-1,idk,	9.70e-1,4.93e-1,
	14.75]	-- http://www.vetlek.ru/shop/?gid=20493&id=5964, 2kg packs
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
plantM = [
		(0.64, oat),
		(0.22, raisins),
		(0.02, parsleyDried),
		(0.10, sunflowerOil),
		(0.02, flaxseedOil)
	]
plantNoGlutenM = [
		(0.58, buckwheat),
		(0.19, raisins),
		(0.19, sunflowerKernel),
		(0.02, parsleyDried),
		(0.02, flaxseed)
	]
seleniumS = (7, brazilNuts)
electrolytesS = [
		(3, naClI),
		(3, kCl),
		(2, caCl)
	]
completeR = (plantM, electrolytesS ++ [
		seleniumS,
		(0.1, ascorbicAcid),
		(0.024, vigantol), -- one drop
		(0.024, retinol) -- one drop
	])
simpleR = (plantM, electrolytesS ++ [
		seleniumS,
		(1, aerovit), -- one pill
		(0.024, vigantol) -- one drop
	])

mix rec = map sum $ transpose $ map (\(frac, l) -> map (frac *) l) $ fst rec

supplements rec p ref = comp (map sum $ transpose $ norm p :
	(map (\(grams, l) -> map ((grams / 100) *) l) $ snd rec)) ref

-- Calculate the energetic value
cal x = 4 * x!!0 + 9 * x!!1 + 4 * x!!2

-- Normalize the mix assuming the 2Mcal diet
norm p = map (* (2000 / (cal $ tail p))) p

-- Compare the mix against the reference
comp p ref = zipWith (/) p ref

tbl rec = map (supplements rec $ mix rec) [replicate sz 1, рсн, fdardi, iomdrirda, iomdriul]

-- Some pretty-printing
printMass :: Double -> String
printMass x
	| x > 2     = printf "%4.1f  g" x
	| x > 2e-3  = printf "%4.1f mg" $ x * 1e3
	| otherwise = printf "%4.1f µg" $ x * 1e6

report rec = putStr $ let [
				w, pr, fa, carb, fib,
				k, na, ca, mg, ph, fe, i, zn, se, cu, cr, mn, mo, cl, fl,
				vA, vC, vD, vE, vK, thi, rib, nia, pant, vB6, bio, fol, vB12, o3, o6,
				his, ile, leu, lys, met, phe, thr, trp, val,
				ala, arg, asn, asp, cys, glu, gln, gly, orn, pro, sel, ser, tyr,
				rur] = map (\(x:xs) -> x : map (* 100) xs) $ transpose $ tbl rec in
	(printf "%-26s %14s %7s %7s %7s %7s\n" "" "mass" "РСН" "FDA RDI" "DRI RDA" "DRI UL") ++
	printf "%-26s %11.0f  g\n" "Total weight" (head w) ++
	concatMap (\(a, [w, b, c, d, e]) -> printf "%-26s %14s %6.0f%% %6.0f%% %6.0f%% %6.0f%%\n" a (printMass w) b c d e) [
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
	printf "%-29s %8.2f\n" "Roubles per 2MCal" (head rur) ++
	printf "%-29s %8.2f\n" "Roubles per 1kg" ((head rur) / (head w) * 1000) ++
	"(*) - see README\n" ++
	"(<letter>) - specified as the sum of components in IOM RDA\n"

main = report simpleR
