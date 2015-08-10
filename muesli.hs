#!/usr/bin/runhaskell
{-# OPTIONS_GHC -fno-warn-tabs #-}
import Control.Exception
import Data.List
import Data.Maybe
import System.Console.ANSI
import System.Environment
import Text.Printf

sz = 64
-- Avoiding typos and other evil stuff haunting us due to the lists being used as the primary data structure
ck :: [Double] -> [Double]
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
-- vita:a,	c,	d,	e,	k,	thiami,	ribofl,	niacin,	pantot,	b6,	biotin,	folate,	b12,	choline,omega3,	omega6,
-- e aa:His,	Ile,	Leu,	Lys,	Met,	Phe,	Thr,	Trp,	Val,
-- o aa:Ala,	Arg,	Asn,	Asp,	Cys,	Glu,	Gln,	Gly,	Orn,	Pro,	Sel,	Ser,	Tyr
-- e fa:ALA,	EPA,	DPA,	DHA,	LA,	GLA,	AA]
raisins = ck		[3,	0.5,	79,	5,	-- USDA 09299 + http://www.whfoods.com/genpage.php?tname=nutrientprofile&dbid=24 + 09298
	0.773,	0.017,	0.044,	0.032,	0.097,	2.1e-3,	idk,	240e-6,	0.63e-6,328e-6,	idk,	0.29e-3,idk,	idk,	220e-6,
	0,	3.6e-3,	0,	120e-6,	3.5e-6,	75e-6,	166e-6,	1e-3,	93e-6,	228e-6,	2e-6,	3.7e-6,	0,	11.1e-3,0,	1e-3,
	7.20e-2,	5.70e-2,	9.60e-2,8.40e-2,	7.70e-2,	6.50e-2,	7.70e-2,	5.00e-2,	8.30e-2,	1.05e-1,	4.13e-1,	idk,	1.10e-1,	1.90e-2,	1.64e-1,	idk,	8.00e-2,	idk,	2.54e-1,	idk,	7.00e-2,	1.20e-2,
	idk,	0.000e0,	0.000e0,	0.000e0,	idk,	idk,	idk]
sunflowerOil = ck	-- USDA 04506, manually corrected assuming 18:2 is LA
	[0.00e0,	100.00e0,	0.00e0,	0.0e0,	0e-3,	0e-3,	0e-3,	0e-3,	0e-3,	0.00e-3,	idk,	0.00e-3,	0.0e-6,	0.000e-3,	idk,	idk,	idk,	idk,	idk,	0e-6,	0.0e-3,	0.0e-6,	41.08e-3,	5.4e-6,	0.000e-3,	0.000e-3,	0.000e-3,	0.000e-3,	0.000e-3,	idk,	0e-6,	0.00e-6,	0.2e-3,	0.0,	65.7,
	0.000e0,	0.000e0,	0.000e0,	0.000e0,	0.000e0,0.000e0,	0.000e0,	0.000e0,	0.000e0,	0.000e0,0.000e0,	idk,	0.000e0,	0.000e0,	0.000e0,	idk,	0.000e0,	idk,	0.000e0,	idk,	0.000e0,	0.000e0,
	idk,	0.000e0,0.000e0,0.000e0,65.7,	idk,	idk]
brazilNuts = ck	-- USDA 12078
	[14.32e0,	67.10e0,	11.74e0,	7.5e0,	659e-3,	3e-3,	160e-3,	376e-3,	725e-3,	2.43e-3,	idk,	4.06e-3,	1917.0e-6,	1.743e-3,	idk,	1.223e-3,	idk,	idk,	idk,	0e-6,	0.7e-3,	0.0e-6,	5.65e-3,	0.0e-6,	0.617e-3,	0.035e-3,	0.295e-3,	0.184e-3,	0.101e-3,	idk,	22e-6,	0.00e-6,	28.8e-3,	1.8e-2,	23.877000000000002,
	0.409e0,	0.518e0,	1.190e0,	0.490e0,	0.365e0,0.639e0,	0.365e0,	0.135e0,	0.760e0,	0.609e0,2.140e0,	idk,	1.325e0,	0.306e0,	3.190e0,	idk,	0.733e0,	idk,	0.706e0,	idk,	0.676e0,	0.416e0,
	0.018e0,	0.000e0,	0.000e0,	0.000e0,	23.859e0,	0.018e0,	idk]
oat = ck	 [	16.89,	6.90e0,66.27e0,	10.6e0,	-- USDA 20038 + http://www.whfoods.com/genpage.php?tname=nutrientprofile&dbid=109
	429e-3,	2e-3,	54e-3,	177e-3,	523e-3,	4.72e-3,6.33e-6,3.97e-3,idk,	626e-6,	13.8e-6,4.91e-3,74e-6,	idk,	idk,
	0e-6,	0.0e-3,0.0e-6,	idk,	idk,	763e-6,	139e-6,	961e-6,	1.34e-3,119e-6,	20e-6,	56e-6,	0.00e-6,17e-3,	idk,	idk,
	0.405e0,0.694e0,	1.284e0,	0.701e0,	0.575e0,	0.895e0,	0.575e0,	0.234e0,	0.937e0,	0.881e0,	1.192e0,	idk,	1.448e0,	0.408e0,	3.712e0,idk,	0.841e0,	idk,	0.934e0,	idk,	0.750e0,	0.573e0,
	idk,	idk,	idk,	idk,	idk,	idk,	idk]
buckwheat = ck	-- USDA 20008
			[13.25e0,	3.40e0,	71.50e0,	10.0e0,	460e-3,	1e-3,	18e-3,	231e-3,	347e-3,	2.20e-3,	idk,	2.40e-3,	8.3e-6,	1.100e-3,	idk,	1.300e-3,	idk,	idk,	idk,	0e-6,	0.0e-3,	0.0e-6,	idk,	idk,	0.101e-3,	0.425e-3,	7.020e-3,	1.233e-3,	0.210e-3,	idk,	30e-6,	0.00e-6,	idk,	idk,	idk,	0.309e0,	0.498e0,	0.832e0,	0.672e0,	0.506e0,	0.520e0,	0.506e0,	0.192e0,	0.678e0,	0.748e0,	0.982e0,	idk,	1.133e0,	0.229e0,	2.046e0,	idk,1.031e0,	idk,	0.507e0,	idk,	0.685e0,	0.241e0,
	idk,	0.000e0,	0.000e0,	0.000e0,	idk,	idk,	idk]
parsley = ck		[2.97e0,7.90e-1,6.33e0,	3.30e0,	-- USDA 11297
	5.54e-1,5.60e-2,1.38e-1,5.00e-2,5.80e-2,6.20e-3,idk,	1.07e-3,1.00e-7,1.49e-4,idk,	1.60e-4,idk,	idk,	idk,
	4.21e-4,idk,	0.00e0,	7.50e-4,1.64e-3,8.60e-5,9.80e-5,1.31e-3,4.00e-4,9.00e-5,idk,	1.52e-4,0.00e0,	12.8e-3,8e-3,	118e-3,	-- http://nutritiondata.self.com/facts/vegetables-and-vegetable-products/2513/2
	6.10e-2,	1.18e-1,	2.04e-1,	1.81e-1,	1.22e-1,	1.45e-1,	1.22e-1,	4.50e-2,1.72e-1,	1.95e-1,	1.22e-1,	idk,	2.94e-1,1.40e-2,	2.49e-1,	idk,	1.45e-1,	idk,	2.13e-1,	idk,	1.36e-1,	8.20e-2,
	idk,	0.000e0,	0.000e0,	0.000e0,	idk,	idk,	idk]
parsleyDried = ck	-- USDA 02029
			[26.63e0,	5.48e0,	50.64e0,	26.7e0,	2683e-3,	452e-3,1140e-3,	400e-3,	436e-3,	22.04e-3,	idk,	5.44e-3,	14.1e-6,0.780e-3,	idk,	9.810e-3,	idk,	idk,	idk,	97e-6,	125.0e-3,	0.0e-6,	8.96e-3,	1359.5e-6,	0.196e-3,	2.383e-3,	9.943e-3,	1.062e-3,	0.900e-3,	idk,	180e-6,	0.00e-6,	97.1e-3,	1.86,	1.264,
	0.718e0,	1.546e0,	2.794e0,	2.098e0,	1.193e0,1.712e0,	1.193e0,	0.475e0,	2.021e0,	1.778e0,1.756e0,	idk,	3.169e0,	0.298e0,	3.688e0,	idk,	1.756e0,	idk,	2.010e0,	idk,	1.159e0,	1.159e0,
	1.860e0,	0.000e0,	0.000e0,	0.000e0,	1.248e0,0.016e0,	idk]
flaxseedOil = ck	-- USDA 42231
			[0.11e0,	99.98e0,	0.00e0,	0.0e0,	0e-3,	0e-3,	1e-3,	0e-3,	1e-3,	0.00e-3,	idk,	0.07e-3,	0.0e-6,	0.000e-3,	idk,	0.000e-3,	idk,	idk,	idk,	0e-6,	0.0e-3,	0.0e-6,0.47e-3,	9.3e-6,	0.000e-3,	0.000e-3,	0.000e-3,	idk,	0.000e-3,	idk,	0e-6,	0.00e-6,	0.2e-3,	53.368,	14.246,
	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,
	53.368e0,	0.000e0,	0.000e0,	0.000e0,	14.246e0,	0.000e0,	idk]
fishOilCodLiver = ck	-- USDA 04589
			[0.00e0,	100.00e0,	0.00e0,	0.0e0,	0e-3,	0e-3,	0e-3,	0e-3,	0e-3,	0.00e-3,	idk,	0.00e-3,	0.0e-6,	0.000e-3,	idk,	0.000e-3,	idk,idk,	idk,	30000e-6,	0.0e-3,	250.0e-6,	idk,	idk,	idk,	0.000e-3,	0.000e-3,	0.000e-3,	0.000e-3,	idk,	0e-6,	0.00e-6,	idk,	18.801000000000002,	0.0,
	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,	idk,
	idk,	6.898e0,	0.935e0,	10.968e0,	idk,	idk,	idk]
eggHardboiled = ck	-- USDA 01129
			[12.58e0,	10.61e0,	1.12e0,	0.0e0,	126e-3,	124e-3,	50e-3,	10e-3,	172e-3,	1.19e-3,	idk,	1.05e-3,	30.8e-6,	0.013e-3,	idk,	0.026e-3,	idk,	idk,	4.8e-6,	149e-6,0.0e-3,	2.2e-6,	1.03e-3,	0.3e-6,	0.066e-3,	0.513e-3,	0.064e-3,	1.398e-3,	0.121e-3,	idk,	44e-6,	1.11e-6,293.8e-3,	4.3e-2,	0.0,
	0.298e0,	0.686e0,	1.075e0,	0.904e0,	0.604e0,0.668e0,	0.604e0,	0.153e0,	0.767e0,	0.700e0,0.755e0,	idk,	1.264e0,	0.292e0,	1.644e0,	idk,	0.423e0,	idk,	0.501e0,	idk,	0.936e0,	0.513e0,
	idk,	0.005e0,	0.000e0,	0.038e0,	idk,	idk,	idk]

naCl = ck		[0,	0,	0,	0,
	0,	39.32,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	60.68,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0]
naClI = ck		[0,	0,	0,	0,
	0,	39.32,	0,	0,	0,	0,	2.5e-3,	0,	0,	0,	0,	0,	0,	60.68,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0]
naHCO3 = ck		[0,	0,	0,	0,
	0,	27.38,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0]
kCl = ck		[0,	0,	0,	0,
	52.41,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	47.6,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0]
kCitrate = ck		[0,	0,	0,	0,	-- K3C6H5O7
	38.235,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0]
kSelenate = ck		[0,	0,	0,	0,	-- K2SeO4
	35.294,	0,	0,	0,	0,	0,	0,	0,	35.747,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0]
caCl = ck		[0,	0,	0,	0,
	0,	0,	36.1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	63.9,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0]
ca2CO3 = ck		[0,	0,	0,	0,
	0,	0,	57.1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0]
iodineEt = ck		[0,	0,	0,	0,	-- pharmaceutical iodine in ethanol 5%
	0,	0,	0,	0,	0,	0,	5,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0]

ascorbicAcid = ck	[0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	100,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0]
d3 = ck			[0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	100,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0]
retinol = ck		[0,	96.04,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	3.96,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0]
aerovit = pills $ ck	[0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	2e-3,	0.1,	0,	20e-3,	0,	2e-3,	2e-3,	15e-3,	9.2e-3,	10e-3,	0,	0.2e-3,	25e-6,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0]
cholineBitartrate = ck	[0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	41.1,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
	0,	0,	0,	0,	0,	0,	0]


-- daily intakes, g at 2Mcal
fdardi = ck		[50,	65,	300,	25,
	4.7,	2.4,	1,	0.4,	1,	18e-3,	150e-6,	15e-3,	70e-6,	0.7e-3,	120e-6,	2e-3,	75e-6,	3.4,	nan,
	0.9e-3,	0.06,	10e-6,	15e-3,	80e-6,	1.5e-3,	1.7e-3,	20e-3,	10e-3,	2e-3,	0.3e-3,	0.4e-3,	6e-6,	nan,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan]
iomdrirda = ck		[nan,	nan,	nan,	nan,
	4.7,	1.5,	1,	0.4,	0.7,	15e-3,	150e-6,	11e-3,	55e-6,	0.9e-3,	35e-6,	2.3e-3,	45e-6,	2.3,	4e-3,
	0.9e-3,	0.09,	15e-6,	15e-3,	120e-6,	1.2e-3,	1.3e-3,	16e-3,	5e-3,	1.3e-3,	30e-6,	0.4e-3,	2.4e-6,	0.55,	1.6,	17,
	0.91,	1.235,	2.730,	2.470,	1.235,	2.145,	1.3,	0.325,	1.56,
	nan,	nan,	nan,	nan,	1.235,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	2.145,
	nan,	nan,	nan,	nan,	nan,	nan,	nan]
iomdriul = ck		[nan,	nan,	nan,	nan,
	nan,	2.3,	2.5,	0.7,	4,	45e-3,	1.1e-3,	40e-3,	400e-6,	10e-3,	nan,	11e-3,	2e-3,	3.6,	10e-3,
	3e-3,	2,	100e-6,	1,	nan,	nan,	nan,	35e-3,	nan,	100e-3,	nan,	1e-3,	nan,	3.5,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan]

-- calculated for 65kg 18-29yo sedentary male, 2450kcal
рсн = ck	[59,	66,	292,	16,	-- balanced for 2000kcal
	2.5,	1.3,	1,	0.4,	0.8,	10e-3,	150e-6,	12e-3,	70e-6,	1e-3,	50e-6,	2e-3,	70e-6,	2.3,	4e-3,
	900e-6,	90e-3,	10e-6,	15e-3,	120e-6,	1.5e-3,	1.8e-3,	20e-3,	5e-3,	2e-3,	50e-6,	400e-6,	3e-6,	0.5,	1.6,	7,
	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan]

-- the difference against iom rda
lpi = ck		[nan,	nan,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,
	nan,	0.4,	50e-6,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,	nan,
	nan,	nan,	nan,	nan,	nan,	nan,	nan]

attenuate l z = map (\(x, y) -> (x * z, y)) l
-- Specify the mix
-- Syntax: (
-- 	[(fraction, product)],	-- meals
-- 	[(grams, product)]	-- supplements
-- 	)
fatsOilsM = [
		(0.065, sunflowerOil),
		(0.025, flaxseedOil)
	]
plantM fats bulk = [
		(0.695, bulk),
		(0.195, raisins),
		(0.02, parsleyDried)
	] ++ fats
electrolytesS = [
		(5, naClI),
		(7, kCitrate),
		(2, ca2CO3)
	]
electrolytesClS = [
		(4, naClI),
		(3, kCl),
		(2, ca2CO3)
	]
myPharmaS = [
		(0.3, ascorbicAcid),
		(3, fishOilCodLiver),
		(1, aerovit), -- one pill
		(125e-6, d3) -- ten drops of vigantol on days w/o at least half an hour of good uvb light exposure
	]
pharmaS = (1, cholineBitartrate) : myPharmaS
seNutsS = (7, brazilNuts)
kSelenateS = (250e-6, kSelenate)
defaultS selenium = selenium : electrolytesS ++ pharmaS

simpleR bulk selenium = (plantM fatsOilsM bulk, defaultS selenium)

mixes = [
		("default", simpleR oat seNutsS),
		("l29ah", (plantM fatsOilsM oat, kSelenateS : electrolytesClS ++ myPharmaS)),
		("l29ah-choline", ((0.3, eggHardboiled) : attenuate (plantM fatsOilsM oat) 0.7, kSelenateS : electrolytesClS ++ myPharmaS)),
		("gluten-free", simpleR buckwheat seNutsS)
	]

mix rec = map sum $ transpose $ map (\(frac, l) -> map (frac *) l) $ fst rec

supplements rec p ref = comp (map sum $ transpose $ norm p :
	(map (\(grams, l) -> map ((grams / 100) *) l) $ snd rec)) ref

-- Calculate the energetic value
cal x = 4 * x!!0 + 9 * x!!1 + 4 * x!!2

-- Normalize the mix assuming the 2Mcal diet
norm p = map (* (2000 / (cal $ tail p))) p

-- Compare the mix against the reference
comp p ref = zipWith (/) p ref

tbl rec = map (supplements rec $ mix rec) [replicate (sz + 1) 1, рсн, fdardi, iomdrirda, iomdriul, lpi]

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
			setSGRCode [SetColor Foreground Vivid (schema x)],
			s,
			setSGRCode [Reset]]

good x = if x < 75 then Red else if x < 125 then Yellow else Green
bad x = if x < 75 then Green else if x < 125 then Yellow else Red

report rec = putStr $ let [
				w, pr, fa, carb, fib,
				k, na, ca, mg, ph, fe, i, zn, se, cu, cr, mn, mo, cl, fl,
				vA, vC, vD, vE, vK, thi, rib, nia, pant, vB6, bio, fol, vB12, cho, o3, o6,
				his, ile, leu, lys, met, phe, thr, trp, val,
				ala, arg, asn, asp, cys, glu, gln, gly, orn, pro, sel, ser, tyr,
				alaa, epa, dpa, dha, la, gla, aa
				] = map (\(x:xs) -> x : map (* 100) xs) $ transpose $ tbl rec in
	(printf "%-26s %14s %7s %7s %7s %7s %7s\n" "" "mass" "РСН" "FDA RDI" "DRI RDA" "LPI" "DRI UL") ++
	printf "%-26s %11.0f  g\n" "Total weight" (head w) ++
	concatMap (\(a, [w, b, c, d, e, lpi]) -> printf "%-26s %14s %s %s %s %s %s\n" a (printMass w) (printPercent good b) (printPercent good c) (printPercent good d) (printPercent good lpi) (printPercent bad e)) [
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
		] ++
	"(*) - see README\n" ++
	"(<letter>) - specified as the sum of components in IOM RDA\n"

usage = do
	pn <- getProgName
	putStr $ "Usage: " ++ pn ++ " <recipe name>\navailable recipes:\n\n" ++ (unlines $ map fst $ mixes)


main = do
	args <- getArgs
	fromMaybe usage $ do
		mixname <- listToMaybe args
		mix <- lookup mixname mixes
		return $ report mix
