module HelperFunctions where

import Data.IORef
import Data.List

objmod n obj = concat (nub (map rotateThrough (filter isPoly (map (\ l -> take n l) (permutations obj)))))

smallest (x:[]) = True
smallest (x:xs) = x <= head xs && smallest (x:tail xs)
smallest _ = True

rotateList (x:xs) = ((last xs):x:(init xs))
rotateList li = li

rotateThrough (x:xs)
  |not (smallest (x:xs)) = rotateThrough (rotateList (x:xs))
  |otherwise = (x:xs)

isPoly (x:y:z:a:[]) = ((calcNormal (vecDir x y) (vecDir y z)) == (calcNormal (vecDir y z) (vecDir z a)))
isPoly (x:y:z:a:xs) = isPoly (x:y:z:a:[]) && isPoly (y:z:a:xs)
isPoly (x:y:z:[]) = True
isPoly (x:y:[]) = True
isPoly _ = False

vecDir (a,b,c) (x,y,z) = (x-a, y-b, z-c)

vecScal (a,b,c) (x,y,z) = a*x+b*y+c*z

vecMult (a,b,c) (x,y,z) = ((b*z)-(c*y), (c*x)-(a*z), (a*y)-(b*x))

vecLen (a,b,c) = sqrt(a*a+b*b+c*c)

normaliz (a,b,c) = (a/vecLen (a,b,c), b/vecLen (a,b,c), c/vecLen (a,b,c))

calcNormal v1 v2 = normaliz (vecMult v1 v2)

new = newIORef
