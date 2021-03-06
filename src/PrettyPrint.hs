module PrettyPrint where 
import Language
import Algebra
import qualified Data.Vector as V
import Data.List

instance Show Type where
    show TInt          = "int"
    show TReal         = "real"
    show (TArray y)    = "[" ++ show y ++ "]" 
    show (TFun y1 y2)  = "(" ++ show y1 ++ " -> " ++ show y2 ++ ")"
    show (TPair y1 y2) = "<" ++ show y1 ++ ", " ++ show y2 ++ ">"

instance Show Term where
    show = foldTerm (fVar, fCReal, fCInt, fCArray, fPair, fFun, fSigmoid, fBinOp, fNew, 
        fLength, fLookup, fUpdate, fMap, fZipWith,
        fFold, fCase, fApply, fComp,
        idTypeAlgebra) where
            fVar         = id
            fCReal       = show
            fCInt        = show
            fCArray y ts = "array : " ++ show y ++ " [" ++ intercalate "," (V.toList ts) ++ "]" 
            -- Pair, case
            fPair t1 t2       = "<" ++ t1 ++ ", " ++ t2 ++ ">"
            fCase t1 x1 x2 t2 = "(case " ++ t1 ++ " of " ++ fPair x1 x2 ++ " -> " ++ t2 ++ ")"
            
            -- The rest
            fNew y size      = ("new " ++ show y) ++ " " ++ size 
            fLookup t1 t2    = t1 ++ "[" ++ t2 ++ "]"
            fUpdate t1 t2 t3 = t1 ++ "[" ++ t2 ++ "] := " ++ t3
            fLength t1       = "len " ++ t1 ++ ""
            fMap t1 t2       = "map " ++ t1 ++ " " ++ t2
            fZipWith f t1 t2 = "zip " ++ f ++ " (" ++ t1 ++ ") (" ++ t2 ++ ")"
            fFold t1 t2 t3   = "fold " ++ t1 ++ " " ++ t2 ++ " " ++ t3
            fFun y1 y2 x t   = "(fun : (" ++ show (TFun y1 y2) ++ ") " ++ x ++ " . " ++ t ++")"
            fApply t1 t2     = t1 ++ " $$ " ++ t2
            fComp t1 t2      = t1 ++ " $. " ++ t2
            
            -- Operators
            fSigmoid t           = "sigmoid(" ++ t ++ ")"
            fBinOp Add  _ t1 t2  = t1 ++ "+" ++ t2
            fBinOp Mult _ t1 t2  = t1 ++ "*" ++ t2
            fBinOp Dot  _ t1 t2  = t1 ++ "@" ++ t2
            

