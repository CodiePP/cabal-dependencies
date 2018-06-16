# cabal dependencies

this tool extracts dependencies from Cabal files and prints them as Prolog terms for further processing.

## extraction

> stack build

> stack exec cabal-dependencies-exe ../my-other-project/project.cabal  > dependencies.pl

## analysis

> swipl -q -t go depdep.pl > dependencies.csv



