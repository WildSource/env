{-|
Module      : Env 
Description : entry point module to use env files
Copyright   : (c) WildSource, 2024
License     : MIT 
Maintainer  : ilovetrap123@hotmail.com
Stability   : stable 
Portability : portable 

this library and is meant to be used with the basic enviroment variable support that Haskell has (System.Environment).

1. import the library (import Env) and System.Environment (we need getEnv)
2. use the loadEnv or loadEnvFile function 
3. to get your values just use the getEnv "nameOfKey" from System.Environment

the difference between loadEnv and loadEnvFile 
 - loadEnv is meant to search automatically for a .env file. It will throw an error if 2 or more (or none) .env files are found
 - loadEnvFile is meant to be used with the path to the .env file (much safer)
-}
module Env (loadEnv, loadEnvFile) where

import System.Environment (setEnv)
import System.Directory (listDirectory)
import Internal (parse)
import Data.List.Utils (contains)

-- | Load the env file specified on the path 
loadEnvFile :: String -> IO ()
loadEnvFile path = 
  (readFile path) >>= (return . lines) >>= loadEnvFile'
  where
    loadEnvFile' :: [String] -> IO () 
    loadEnvFile' [] = pure ()  
    loadEnvFile' [x] = loadEnvValue x
    loadEnvFile' (x:xs) = 
      loadEnvValue x >> loadEnvFile' xs

    loadEnvValue :: String -> IO ()
    loadEnvValue rawData = 
      let (k, v) = parse rawData
      in setEnv k v

-- | Load the first env file found
loadEnv :: IO () 
loadEnv = 
  listDirectory  "." 
  >>= (pure . strain . filter (isEnv)) 
  >>= loadEnvFile 
  where
    isEnv :: String -> Bool
    isEnv = contains ".env" 

    strain :: [String] -> String
    strain x 
      | length x > 1 = error "2 or more .env files were found"
      | concat x == "" = error "no .env file was found"
      | otherwise = concat x
