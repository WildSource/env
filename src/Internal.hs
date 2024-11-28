{-# LANGUAGE OverloadedStrings #-}

module Internal where

import Data.Text (Text, splitOn, pack, unpack)

type Key = String 
type Value = String 

-- | parses the value of the .env file
parse :: String -> (Key, Value)
parse lexime = 
  let rawList = splitOn "=" $ pack lexime
  in genKV rawList 
  where
    genKV :: [Text] -> (Key, Value)
    genKV [h, t] = mapTuple (h, t) unpack
    genKV _ = ("","")

-- | maps a function f to a tuple
mapTuple :: (a,a) -> (a -> b) -> (b,b)
mapTuple (v, v') f = (f v, f v')
