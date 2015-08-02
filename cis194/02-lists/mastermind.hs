data Peg = Red | Green | Blue | Yellow | Orange | Purple
  deriving (Eq, Show)
type Code = [Peg]

colors = [Red, Green, Blue, Yellow, Orange, Purple]

exactMatches :: Code -> Code -> Int
exactMatches [] [] = 0
exactMatches (x:xs) (y:ys)
  | x == y = 1 + exactMatches xs ys
  | otherwise = exactMatches xs ys

countColors :: Code -> [Int]
countColors xs = map (\x -> exactMatches (replicate (length xs) x) xs) colors 