module Main where

import Language
import Forward
import PrettyPrint
import Variable
import AbstractMachine

main :: IO ()
main = putStrLn "Hello, Haskell!"

example0 :: Term 
example0 = Mult (CReal 2) (Var "x")

example :: Term
example = Apply (Fun TReal TReal "y" (Mult (Var "y") (Var "y"))) (CReal 10)

exampleFst :: Term
exampleFst = Fun (TPair TReal TReal) (TReal) "x" (Case (Var "x") "id1" "id2" (Var "id1") )

example2 :: Term
example2 = Fun TReal TReal "x" ((Fun TReal TReal "x" (Var "x" `Mult` Var "x")) `Apply` (Var "x"))
