{-# LANGUAGE DataKinds, FlexibleContexts #-}
{-# OPTIONS_GHC -fno-warn-tabs #-}
module DatabaseTools where

import qualified Data.Vector.Fixed as F
import Data.Vector.Fixed (ContVec, S)
import qualified Data.Vector.Fixed.Cont as C
import Data.Vector.Fixed.Cont (ToPeano(..))

-- xcompose'able space saver
(♥) :: a -> ContVec n a -> ContVec (S n) a
(♥) = (C.cons)
infixr 1 ♥

-- TODO a better value that taints the calculation
idk :: Double
idk = 0

-- Put 'nan' when the value is unspecified or irrelevant in the target daily uptakes
nan = 0/0

-- Put 'todo' when the value is to be fetched
todo = idk

-- USDA considers fiber a carbohydrate, we don't
usda v = F.set (undefined :: ToPeano 2) ((F.index v (undefined :: ToPeano 2)) - (F.index v (undefined :: ToPeano 3))) v
