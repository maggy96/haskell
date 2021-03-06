module HW04 where

newtype Poly a = P [a]

-- Exercise 1 -----------------------------------------

x :: Num a => Poly a
x = P [0, 1]

-- Exercise 2 ----------------------------------------

instance (Num a, Eq a) => Eq (Poly a) where
    (P p1) == (P p2) = p1 == p2
 
-- Exercise 3 -----------------------------------------

instance (Num a, Eq a, Show a) => Show (Poly a) where
    show (P p1) = prettyPrint (reverse p1) (length p1 - 1)
        where prettyPrint []  _  = ""
              prettyPrint [y] 0  = show y
              prettyPrint (y:ys) n 
                | y /= 0    = show y ++ "x^" ++ show n ++ " + " ++ 
                              prettyPrint ys (n - 1)
                | otherwise = prettyPrint ys (n - 1)

-- Exercise 4 -----------------------------------------

plus :: Num a => Poly a -> Poly a -> Poly a
plus (P p1) (P p2) = P (addPoly p1 p2)
    where addPoly (y:ys) (z:zs) = (y + z) : addPoly ys zs
          addPoly []     (y:ys) = y : addPoly [] ys
          addPoly (y:ys) []     = y : addPoly [] ys
          addPoly _      _      = []

-- Exercise 5 -----------------------------------------

times :: Num a => Poly a -> Poly a -> Poly a
times (P p1) (P p2) = foldl (+) (P [0]) $ multiply p1 p2 
    where
    multiply [] _ = []
    multiply (y:ys) zs 
        = (P (map (* y) zs)) : (multiply ys (0 : zs))

-- Exercise 6 -----------------------------------------

instance Num a => Num (Poly a) where
    (+) = plus
    (*) = times
    negate      (P p1) = P $ map negate p1
    fromInteger n      = P [fromInteger n]
    -- No meaningful definitions exist
    abs    = undefined
    signum = undefined

-- Exercise 7 -----------------------------------------

applyP :: Num a => Poly a -> a -> a
applyP (P p1) n = ap1 p1 0
    where 
        ap1 (p:ps) h = p * n ^ h + ap1 ps (h + 1)
        ap1 [] _ = 0

-- Exercise 8 -----------------------------------------

class Num a => Differentiable a where
    deriv  :: a -> a
    deriv  = undefined --(p:ps) = ps
    nderiv :: Int -> a -> a
    nderiv 1 n = deriv n
    nderiv n s = deriv(nderiv (n - 1) s)

-- Exercise 9 -----------------------------------------

instance Num a => Differentiable (Poly a) where
    deriv (P a) =  P $ helper (tail a) 1
        where helper [] _ = []
              helper (h:t) n = (n*h):(helper t (n+1))