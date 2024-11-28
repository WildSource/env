module Env (loadEnv, loadEnvFile) where

import System.Environment (setEnv)
import System.Directory (listDirectory)
import Internal (parse)
import Data.List.Utils (contains)
import Data.Bool.HT (if')

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

-- | Predicate used by the loadEnv function to verify if there are more than 1 .env file 
isEnv :: String -> Bool
isEnv = contains ".env" 

-- | If there are 2 or more .env file throw an error 
strain :: [String] -> String
strain x = 
  if' (((1==) . length) x) (concat x) (error "more than 2 .env file found")
