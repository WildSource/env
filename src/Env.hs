{-# LANGUAGE OverloadedStrings #-}

module Env where

import Data.Text (Text, splitOn, pack, unpack)
import System.Environment (setEnv)

type Key = Text 
type Value = Text 

-- | Load the env file specified on the path 
loadEnvFile :: String -> IO ()
loadEnvFile path = 
  let content = (readFile path) >>= (return . lines)
  in content >>= loadEnvFile'
    where
    loadEnvFile' :: [String] -> IO () 
    loadEnvFile' [] = pure ()  
    loadEnvFile' [x] = loadEnvValue x
    loadEnvFile' (x:xs) = 
      loadEnvValue x >> loadEnvFile' xs

    loadEnvValue :: String -> IO ()
    loadEnvValue rawData = 
      let (k, v) = mapTuple (parse $ pack rawData) (unpack)
      in setEnv k v

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

mapTuple :: (a,a) -> (a -> b) -> (b,b)
mapTuple (v, v') f = (f v, f v')
