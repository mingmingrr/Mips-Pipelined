{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}

data Field = Field
  { name :: String
  , width :: String
  } deriving (Eq, Show)

type Struct = [Field]

class Source a where
  source :: a -> String

instance Source Struct where
  source fs =
    let field Field{..} = name
     in unlines $ map field fs

main = do
  let x = Field "a" "1"
  print $ source [x]
