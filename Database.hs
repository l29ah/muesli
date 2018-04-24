{-# OPTIONS_GHC -fno-warn-tabs #-}
module Database where

import qualified Data.Vector.Fixed as F

import DatabaseTools
import Types

-- nuts:prote,	fat,	carbs,	fiber,
-- elem:potass,	sodium,	calciu,	magnes,	phosph,	iron,	iodine,	zinc,	seleni,	copper,	chromi,	mangane,molybde,chlorid,fluoride,
-- vita:a,	c,	d,	e,	k,	thiami,	ribofl,	niacin,	pantot,	b6,	biotin,	folate,	b12,	choline,omega3,	omega6,
-- e aa:His,	Ile,	Leu,	Lys,	Met,	Phe,	Thr,	Trp,	Val,
-- o aa:Ala,	Arg,	Asn,	Asp,	Cys,	Glu,	Gln,	Gly,	Orn,	Pro,	Sel,	Ser,	Tyr
-- e fa:ALA,	EPA,	DPA,	DHA,	LA,	GLA,	AA
--                               ↘per 100g
raisins = Source "raisin" $ Substance 100 $ usda $ F.vector $
	3♥	0.5♥	79♥	5♥	-- USDA 09299 + http://www.whfoods.com/genpage.php?tname=nutrientprofile&dbid=24 + 09298
	0.773♥	0.017♥	0.044♥	0.032♥	0.097♥	2.1e-3♥	idk♥	240e-6♥	0.63e-6♥328e-6♥	idk♥	0.29e-3♥idk♥	idk♥	220e-6♥
	0♥	3.6e-3♥	0♥	120e-6♥	3.5e-6♥	75e-6♥	166e-6♥	1e-3♥	93e-6♥	228e-6♥	2e-6♥	3.7e-6♥	0♥	11.1e-3♥0♥	1e-3♥
	7.20e-2♥	5.70e-2♥	9.60e-2♥8.40e-2♥	7.70e-2♥	6.50e-2♥	7.70e-2♥	5.00e-2♥	8.30e-2♥	1.05e-1♥	4.13e-1♥	idk♥	1.10e-1♥	1.90e-2♥	1.64e-1♥	idk♥	8.00e-2♥	idk♥	2.54e-1♥	idk♥	7.00e-2♥	1.20e-2♥
	idk♥	0.000e0♥	0.000e0♥	0.000e0♥	idk♥	idk♥	idk♥F.empty

undevit = Source "undevit" $ Pill $ F.vector $
	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	1e-3♥	75e-3♥	0♥	10e-3♥	0♥	2e-3♥	2e-3♥	20e-3♥	3e-3♥	3e-3♥	0♥	70e-6♥	2e-6♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥F.empty
sunflowerOil = Source "sunfloweroil" $ Substance 100 $ usda $ F.vector $	-- USDA 04506, manually corrected assuming 18:2 is LA
	0.00e0♥	100.00e0♥	0.00e0♥	0.0e0♥	0e-3♥	0e-3♥	0e-3♥	0e-3♥	0e-3♥	0.00e-3♥	idk♥	0.00e-3♥	0.0e-6♥	0.000e-3♥	idk♥	idk♥	idk♥	idk♥	idk♥	0e-6♥	0.0e-3♥	0.0e-6♥	41.08e-3♥	5.4e-6♥	0.000e-3♥	0.000e-3♥	0.000e-3♥	0.000e-3♥	0.000e-3♥	idk♥	0e-6♥	0.00e-6♥	0.2e-3♥	0.0♥	65.7♥
	0.000e0♥	0.000e0♥	0.000e0♥	0.000e0♥	0.000e0♥0.000e0♥	0.000e0♥	0.000e0♥	0.000e0♥	0.000e0♥0.000e0♥	idk♥	0.000e0♥	0.000e0♥	0.000e0♥	idk♥	0.000e0♥	idk♥	0.000e0♥	idk♥	0.000e0♥	0.000e0♥
	idk♥	0.000e0♥0.000e0♥0.000e0♥65.7♥	idk♥	idk♥F.empty
brazilNuts = Source "brazilnuts" $ Substance 100 $ usda $ F.vector $	-- USDA 12078
	14.32e0♥	67.10e0♥	11.74e0♥	7.5e0♥	659e-3♥	3e-3♥	160e-3♥	376e-3♥	725e-3♥	2.43e-3♥	idk♥	4.06e-3♥	1917.0e-6♥	1.743e-3♥	idk♥	1.223e-3♥	idk♥	idk♥	idk♥	0e-6♥	0.7e-3♥	0.0e-6♥	5.65e-3♥	0.0e-6♥	0.617e-3♥	0.035e-3♥	0.295e-3♥	0.184e-3♥	0.101e-3♥	idk♥	22e-6♥	0.00e-6♥	28.8e-3♥	1.8e-2♥	23.877000000000002♥
	0.409e0♥	0.518e0♥	1.190e0♥	0.490e0♥	0.365e0♥0.639e0♥	0.365e0♥	0.135e0♥	0.760e0♥	0.609e0♥2.140e0♥	idk♥	1.325e0♥	0.306e0♥	3.190e0♥	idk♥	0.733e0♥	idk♥	0.706e0♥	idk♥	0.676e0♥	0.416e0♥
	0.018e0♥	0.000e0♥	0.000e0♥	0.000e0♥	23.859e0♥	0.018e0♥	idk♥F.empty
oat = Source "oat" $ Substance 100 $ usda $ F.vector $	-- USDA 08120 + http://www.whfoods.com/genpage.php?tname=nutrientprofile&dbid=109
	13.15e0♥	6.52e0♥	67.70e0♥	10.1e0♥
	362e-3♥	6e-3♥	52e-3♥	138e-3♥	410e-3♥	4.25e-3♥	idk♥	3.64e-3♥	28.9e-6♥	0.391e-3♥	idk♥	3.630e-3♥	idk♥	idk♥	idk♥
	0e-6♥	0.0e-3♥	0.0e-6♥	0.42e-3♥	2.0e-6♥	0.460e-3♥	0.155e-3♥	1.125e-3♥	1.120e-3♥	0.100e-3♥	idk♥	32e-6♥	0.00e-6♥	40.4e-3♥	0.0♥	0.0♥
	0.405e0♥0.694e0♥	1.284e0♥	0.701e0♥	0.575e0♥	0.895e0♥	0.575e0♥	0.234e0♥	0.937e0♥	0.881e0♥	1.192e0♥	idk♥	1.448e0♥	0.408e0♥	3.712e0♥idk♥	0.841e0♥	idk♥	0.934e0♥	idk♥	0.750e0♥	0.573e0♥
	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥F.empty
buckwheat = Source "buckwheat" $ Substance 100 $ usda $ F.vector $	-- USDA 20008
	13.25e0♥	3.40e0♥	71.50e0♥	10.0e0♥	460e-3♥	1e-3♥	18e-3♥	231e-3♥	347e-3♥	2.20e-3♥	idk♥	2.40e-3♥	8.3e-6♥	1.100e-3♥	idk♥	1.300e-3♥	idk♥	idk♥	idk♥	0e-6♥	0.0e-3♥	0.0e-6♥	idk♥	idk♥	0.101e-3♥	0.425e-3♥	7.020e-3♥	1.233e-3♥	0.210e-3♥	idk♥	30e-6♥	0.00e-6♥	idk♥	idk♥	idk♥	0.309e0♥	0.498e0♥	0.832e0♥	0.672e0♥	0.506e0♥	0.520e0♥	0.506e0♥	0.192e0♥	0.678e0♥	0.748e0♥	0.982e0♥	idk♥	1.133e0♥	0.229e0♥	2.046e0♥	idk♥1.031e0♥	idk♥	0.507e0♥	idk♥	0.685e0♥	0.241e0♥
	idk♥	0.000e0♥	0.000e0♥	0.000e0♥	idk♥	idk♥	idk♥F.empty
parsley = Source "parsley" $ Substance 100 $ usda $ F.vector $	-- USDA 11297
	2.97e0♥7.90e-1♥6.33e0♥	3.30e0♥
	5.54e-1♥5.60e-2♥1.38e-1♥5.00e-2♥5.80e-2♥6.20e-3♥idk♥	1.07e-3♥1.00e-7♥1.49e-4♥idk♥	1.60e-4♥idk♥	idk♥	idk♥
	4.21e-4♥idk♥	0.00e0♥	7.50e-4♥1.64e-3♥8.60e-5♥9.80e-5♥1.31e-3♥4.00e-4♥9.00e-5♥idk♥	1.52e-4♥0.00e0♥	12.8e-3♥8e-3♥	118e-3♥	-- http://nutritiondata.self.com/facts/vegetables-and-vegetable-products/2513/2
	6.10e-2♥	1.18e-1♥	2.04e-1♥	1.81e-1♥	1.22e-1♥	1.45e-1♥	1.22e-1♥	4.50e-2♥1.72e-1♥	1.95e-1♥	1.22e-1♥	idk♥	2.94e-1♥1.40e-2♥	2.49e-1♥	idk♥	1.45e-1♥	idk♥	2.13e-1♥	idk♥	1.36e-1♥	8.20e-2♥
	idk♥	0.000e0♥	0.000e0♥	0.000e0♥	idk♥	idk♥	idk♥F.empty
parsleyDried = Source "parsleydried" $ Substance 100 $ usda $ F.vector $	-- USDA 02029
	26.63e0♥	5.48e0♥	50.64e0♥	26.7e0♥	2683e-3♥	452e-3♥1140e-3♥	400e-3♥	436e-3♥	22.04e-3♥	idk♥	5.44e-3♥	14.1e-6♥0.780e-3♥	idk♥	9.810e-3♥	idk♥	idk♥	idk♥	97e-6♥	125.0e-3♥	0.0e-6♥	8.96e-3♥	1359.5e-6♥	0.196e-3♥	2.383e-3♥	9.943e-3♥	1.062e-3♥	0.900e-3♥	idk♥	180e-6♥	0.00e-6♥	97.1e-3♥	1.86♥	1.264♥
	0.718e0♥	1.546e0♥	2.794e0♥	2.098e0♥	1.193e0♥1.712e0♥	1.193e0♥	0.475e0♥	2.021e0♥	1.778e0♥1.756e0♥	idk♥	3.169e0♥	0.298e0♥	3.688e0♥	idk♥	1.756e0♥	idk♥	2.010e0♥	idk♥	1.159e0♥	1.159e0♥
	1.860e0♥	0.000e0♥	0.000e0♥	0.000e0♥	1.248e0♥0.016e0♥	idk♥F.empty
flaxseedOil = Source "flaxseedoil" $ Substance 100 $ usda $ F.vector $	-- USDA 42231
	0.11e0♥	99.98e0♥	0.00e0♥	0.0e0♥	0e-3♥	0e-3♥	1e-3♥	0e-3♥	1e-3♥	0.00e-3♥	idk♥	0.07e-3♥	0.0e-6♥	0.000e-3♥	idk♥	0.000e-3♥	idk♥	idk♥	idk♥	0e-6♥	0.0e-3♥	0.0e-6♥0.47e-3♥	9.3e-6♥	0.000e-3♥	0.000e-3♥	0.000e-3♥	idk♥	0.000e-3♥	idk♥	0e-6♥	0.00e-6♥	0.2e-3♥	53.368♥	14.246♥
	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥
	53.368e0♥	0.000e0♥	0.000e0♥	0.000e0♥	14.246e0♥	0.000e0♥	idk♥F.empty
fishOilCodLiver = Source "codliveroil" $ Substance 100 $ usda $ F.vector $	-- USDA 04589
	0.00e0♥	100.00e0♥	0.00e0♥	0.0e0♥	0e-3♥	0e-3♥	0e-3♥	0e-3♥	0e-3♥	0.00e-3♥	idk♥	0.00e-3♥	0.0e-6♥	0.000e-3♥	idk♥	0.000e-3♥	idk♥idk♥	idk♥	30000e-6♥	0.0e-3♥	250.0e-6♥	idk♥	idk♥	idk♥	0.000e-3♥	0.000e-3♥	0.000e-3♥	0.000e-3♥	idk♥	0e-6♥	0.00e-6♥	idk♥	18.801000000000002♥	0.0♥
	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥	idk♥
	idk♥	6.898e0♥	0.935e0♥	10.968e0♥	idk♥	idk♥	idk♥F.empty
eggHardboiled = Source "egghardboiled" $ Substance 100 $ usda $ F.vector $	-- USDA 01129
	12.58e0♥	10.61e0♥	1.12e0♥	0.0e0♥	126e-3♥	124e-3♥	50e-3♥	10e-3♥	172e-3♥	1.19e-3♥	idk♥	1.05e-3♥	30.8e-6♥	0.013e-3♥	idk♥	0.026e-3♥	idk♥	idk♥	4.8e-6♥	149e-6♥0.0e-3♥	2.2e-6♥	1.03e-3♥	0.3e-6♥	0.066e-3♥	0.513e-3♥	0.064e-3♥	1.398e-3♥	0.121e-3♥	idk♥	44e-6♥	1.11e-6♥293.8e-3♥	4.3e-2♥	0.0♥
	0.298e0♥	0.686e0♥	1.075e0♥	0.904e0♥	0.604e0♥0.668e0♥	0.604e0♥	0.153e0♥	0.767e0♥	0.700e0♥0.755e0♥	idk♥	1.264e0♥	0.292e0♥	1.644e0♥	idk♥	0.423e0♥	idk♥	0.501e0♥	idk♥	0.936e0♥	0.513e0♥
	idk♥	0.005e0♥	0.000e0♥	0.038e0♥	idk♥	idk♥	idk♥F.empty
soyflourdefatted = Source "soyflourdefatted" $ Substance 100 $ usda $ F.vector $	-- USDA 16117
	51.46e0♥	1.22e0♥	33.92e0♥	17.5e0♥
	2384e-3♥	20e-3♥	241e-3♥	290e-3♥	674e-3♥	9.24e-3♥	idk♥	2.46e-3♥	1.7e-6♥	4.065e-3♥	idk♥	3.018e-3♥	idk♥	idk♥	idk♥
	2e-6♥	0.0e-3♥	0.0e-6♥	0.12e-3♥	4.1e-6♥	0.698e-3♥	0.253e-3♥	2.612e-3♥	1.995e-3♥	0.574e-3♥	idk♥	305e-6♥	0.00e-6♥	11.3e-3♥	0.0♥	0.0♥
	1.268e0♥	2.281e0♥	3.828e0♥	3.129e0♥	2.042e0♥	2.453e0♥	2.042e0♥	0.683e0♥	2.346e0♥	2.215e0♥	3.647e0♥	idk♥	5.911e0♥	0.757e0♥	9.106e0♥	idk♥	2.174e0♥	idk♥	2.750e0♥	idk♥	2.725e0♥	1.778e0♥
	idk♥	0.000e0♥	0.000e0♥	0.000e0♥	idk♥	idk♥	idk♥F.empty

naCl = Source "nacl" $ Substance 100 $ F.vector $
	0♥	0♥	0♥	0♥
	0♥	39.32♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	60.68♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥F.empty
naClI = Source "nacl" $ Substance 100 $ F.vector $
	0♥	0♥	0♥	0♥
	0♥	39.32♥	0♥	0♥	0♥	0♥	2.5e-3♥	0♥	0♥	0♥	0♥	0♥	0♥	60.68♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥F.empty
kCl = Source "kcl" $ Substance 100 $ F.vector $
	0♥	0♥	0♥	0♥
	52.41♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	47.6♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥F.empty
kCitrateH2O = Source "kcitrate" $ Substance 100 $ F.vector $	-- K3C6H7O8
	0♥	0♥	0♥	0♥
	36.111♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥F.empty
kSelenate = Source "kselenate" $ Substance 100 $ F.vector $	-- K2SeO4
	0♥	0♥	0♥	0♥
	35.294♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	35.747♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥F.empty
caCl = Source "cacl" $ Substance 100 $ F.vector $
	0♥	0♥	0♥	0♥
	0♥	0♥	36.1♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	63.9♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥F.empty
ca2CO3 = Source "chalk" $ Substance 100 $ F.vector $
	0♥	0♥	0♥	0♥
	0♥	0♥	57.1♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥F.empty

ascorbicAcid = Source "ascorbica" $ Substance 100 $ F.vector $
	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	100♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥F.empty
d3 = Source "d3" $ Substance 100 $ F.vector $
	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	100♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥F.empty
vigantol = Source "vigantol" $ Pill $ F.vector $
	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	12.5e-6♥0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥F.empty
nowD35000 = Source "nowd3-5000" $ Pill $ F.vector $
	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	125e-6♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥F.empty
cholineBitartrate = Source "cholinebitartrate" $ Substance 100 $ F.vector $
	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	41.1♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥F.empty
snK = Source "sourcenaturalsk" $ Pill $ F.vector $
	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0.5e-3♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥	0♥
	0♥	0♥	0♥	0♥	0♥	0♥	0♥F.empty
