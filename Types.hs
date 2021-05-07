{-# LANGUAGE DataKinds, TypeFamilies, UndecidableInstances #-}
{-# OPTIONS_GHC -fno-warn-tabs #-}
module Types where

import Data.Vector.Fixed.Boxed as V

type Kcal = Double
type Grams = Double
type Elements = 64
type Nutrients = V.Vec Elements Grams

data Component = Substance
	{ sServingMass :: Grams	-- the total mass of the component described by sNutrients
	, sNutrients :: Nutrients
	} | Pill
	{ pNutrients :: Nutrients
	} deriving Show

data Source = Source
	{ sProdName :: String
	, sComponent :: Component
	} deriving Show

type RecipeName = String
type Amount = Double
data Recipe = Recipe
	{ rFoods :: [(Amount, Source)]
	, rSupplements :: [(Amount, Source)]
	} deriving Show
