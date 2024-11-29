# Env
An extremely simple library to support env files.
This library is meant to be used with the basic environment variable support that Haskell has (System.Environment).
## Installation 
This package has not yet been uploaded to hackage but the source code is available.
You could compile it and include manually or something.
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
