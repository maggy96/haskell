myLast :: [a] -> a
myLast = head . reverse

myButLast :: [a] -> a
myButLast x = x !! (length x - 2)

elementAt :: [a] -> Int -> a
elementAt list i = list !! (i - 1)

myLength :: [a] -> Int
myLength xs = sum [1 | _ <- xs]

myReverse :: [a] -> [a]
myReverse xs = case xs of
        [] -> []
        (x:xs) -> myReverse xs ++ [x]

isPalindrome :: Eq a => [a] -> Bool
isPalindrome xs = xs == myReverse xs

compress (x:ys@(y:_))
    | x == y    = compress ys
    | otherwise = x : compress ys
compress ys = ys

main = do
    print $ myLast [1,2,3,4]
    print $ myButLast [1,2,3,4]
    print $ elementAt [1,2,3] 2
    print $ myLength [123, 456, 789]
    print $ myReverse [1,2,3,4]
    print $ compress "aaaabccaadeeee"
