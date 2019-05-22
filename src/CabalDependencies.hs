-- | extract dependencies from a cabal file
module CabalDependencies
    ( parse
    ) where


import Control.Monad (forM)

import Data.List (nub, sort)

import Distribution.PackageDescription.Parsec
import Distribution.PackageDescription
import Distribution.Verbosity
import Distribution.Package


parse :: String -> IO (String, [String])
parse fp = do
  d <- readGenericPackageDescription normal fp
  -- extract name of cabal package
  let n = unPackageName $ pkgName . package $ packageDescription d
  return $ (n, nub {-. sort-} $ parseLib d
        ++ (parseExecs d)
        ++ (parseTests d)
        ++ (parseBenchmarks d)
      )

parseLib d =
    case condLibrary d of
      Nothing -> return []
      Just deps -> parseDeps deps

parseDeps deps =
    (\(Dependency dname _) -> unPackageName dname) <$> condTreeConstraints deps

parseExecs d =
    concat $ forM (condExecutables d) $
        \(x, deps) -> parseDeps deps

parseTests d =
    concat $ forM (condTestSuites d) $
        \(x, deps) -> parseDeps deps

parseBenchmarks d =
    concat $ forM (condBenchmarks d) $
        \(x, deps) -> parseDeps deps

