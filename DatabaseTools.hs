{-# LANGUAGE DataKinds, FlexibleContexts, TypeFamilies #-}
{-# OPTIONS_GHC -fno-warn-tabs #-}
module DatabaseTools where

import Data.Proxy
import qualified Data.Vector.Fixed as F
import qualified Data.Vector.Fixed.Cont as C

import Types

mkL = F.mkN (Proxy :: Proxy Nutrients)

-- TODO a better value that taints the calculation
idk :: Double
idk = 0

-- Put 'nan' when the value is unspecified or irrelevant in the target daily uptakes
nan = 0/0

-- Put 'todo' when the value is to be fetched
todo = idk

-- USDA considers fiber a carbohydrate, we don't
usda v = F.set (Proxy :: Proxy 2) ((F.index v (Proxy :: Proxy 2)) - (F.index v (Proxy :: Proxy 3))) v
