type Line = (Int, Int, Char, String)

xor a b = (a || b) && (not (a && b))

--Parse each line
parse :: [String] -> Line
parse [is,(c:_),s] = (read a, read b', c, s)
  where
    (a, b) = break (=='-') is
    b' = tail b
parse _ = error "Parse error"

star1 :: Line -> Bool
star1 (lo, hi, c, s) = lo <= occurences && occurences <= hi
      where occurences = length $ filter (==c) s

star2 :: Line -> Bool
star2 (lo, hi, c, s) = (indexEq lo) `xor` (indexEq hi)
      where indexEq idx = (s !! (idx-1)) == c

main :: IO ()
main = do
  contents <- getContents
  let ls = map (parse . words) $ lines contents
  putStrLn $ "Star 1: " ++ (show $ length $ filter star1 ls)
  putStrLn $ "Star 2: " ++ (show $ length $ filter star2 ls)
