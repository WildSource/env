# Env
An extremely simple library to support env files.
This library is meant to be used with the basic environment variable support that Haskell has (System.Environment).
## Installation 
This package is not on hackage but cabal (and stack) let's you use packages that are on github.
(I don't use stack so you will have to figure it out yourself)

1. Create cabal.project file if you don't have one already at the root of your project.
   Essentially at the same location as your .cabal file and put this in the cabal.project file.
   ```
   packages: .

   source-repository-package
   type: git
   location: https://github.com/WildSource/env
   tag: v1.0.0.0
   ```
2. Add the library to your .cabal file.
   ```
   -- Other library packages from which modules are imported.
    build-depends:    base ^>=4.17.2.1,
                      env
   ```
3. Execute the **cabal update** and **cabal build** commands and you should be good to go.
## Usage
1. import the library (import Env) and System.Environment (we need getEnv)
```
import Env
import System.Environment
```
2. use the loadEnv or loadEnvFile function
```
loadEnv
```
or
```
loadEnvFile "pathToEnv.env"
```
3. to get your values just use the getEnv "nameOfKey" from System.Environment
> inside the env file -> HELLO=WORLD
```
getEnv "HELLO"
```
> output
```
"WORLD"
```
