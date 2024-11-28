{-# LANGUAGE OverloadedStrings #-}

module Env where

import Data.Text (Text, splitOn)

type Key = Text 
type Value = Text 

-- | Load the env file specified on the path 
loadEnvFile :: String -> IO ()
loadEnvFile path = 
  let content = readFile path 
  in putStrLn $ content >>= lines 
-- | Load the the first found env file
loadEnv :: IO ()
loadEnv = undefined

parse :: Text -> (Key, Value)
parse lexime = 
  let rawList = splitOn "=" lexime
  in genKV rawList 
  where
    genKV :: [Text] -> (Key, Value)
    genKV [h, t] = (h, t)
    genKV _ = ("","")
