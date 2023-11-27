doTheThing :: [String] -> [Int]
doTheThing [] = []
doTheThing [_] = []
doTheThing (_:y:xs) = result : doTheThing xs
  where
    -- do the thing
    result = [0]

main = interact $ unlines . map show . doTheThing . tail . lines
-- main = interact $ unlines . map show . doTheThing . map read . tail . lines
