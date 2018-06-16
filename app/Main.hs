-- | program
module Main where

import Control.Monad (forM_)
import System.Environment (getArgs)

import CabalDependencies

main :: IO ()
main = do
  args <- getArgs
  case args of
    []   -> putStrLn "missing input file"
    fps -> do
      forM_ fps (\fp -> doParse fp)

 where
   doParse fp = do
      (n, ds) <- parse fp
      forM_ ds (\d -> putStrLn $ "dependency('" ++ n ++ "', '" ++ d ++ "').")
