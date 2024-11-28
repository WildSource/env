module Env where

import System.Environment (setEnv)
import Internal (parse)

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

-- | Load the the first found env file
loadEnv :: IO ()
loadEnv = undefined
