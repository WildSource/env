{-# LANGUAGE OverloadedStrings #-}

module Internal where

import Data.Text (Text, splitOn, pack, unpack)

type Key = String 
type Value = String 

parse :: String -> (Key, Value)
parse lexime = 
  let rawList = splitOn "=" $ pack lexime
  in genKV rawList 
  where
    genKV :: [Text] -> (Key, Value)
    genKV [h, t] = mapTuple (h, t) unpack
    genKV _ = ("","")

mapTuple :: (a,a) -> (a -> b) -> (b,b)
mapTuple (v, v') f = (f v, f v')
