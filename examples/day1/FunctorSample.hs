module Main where

import qualified Data.Map as Map
import Html

{-- 
    Definition of a Functor: Type class that only needs one definition 
        fmap :: Functor f => (a -> b) -> fa -> fb
    We could use <$> as an infix function
    Note: f in the functor definition is not related to a function is the functor itself
    it could be List, Maybe or whatever
--}

-- Definition of fake request that gets an Int value

successFullRequest :: Maybe Int
successFullRequest = Just 10

failedRequest :: Maybe Int
failedRequest = Nothing

-- Robot sample

data RobotPart = RobotPart
    { name :: String
    , description :: String
    , cost :: Double
    , count :: Int 
    } deriving Show

leftArm :: RobotPart 
leftArm = RobotPart
    { name = "left arm"
    , description = "left arm for face punching!"
    , cost = 1025.00
    , count = 3  
    } 

rightArm :: RobotPart 
rightArm = RobotPart 
    { name = "right arm"
    , description = "right arm for kind  hand gestures"
    , cost = 1100.00
    , count = 5 
    } 

robotHead :: RobotPart
robotHead = RobotPart 
    { name = "robot head"
    , description = "this head looks mad"
    , cost = 5092.25
    , count = 2 
    } 

-- Type alias

renderHtml :: RobotPart -> Html
renderHtml part = mconcat [
    header H2 $ name part,
    p $ header H3 "desc" ++ description part,
    p $ header H3 "cost" ++ (show $ cost part),
    p $ header H3 "count" ++ (show $ count part) ]

partsDB :: Map.Map Int RobotPart
partsDB = Map.fromList keyVals
    where 
        keys = [1, 2, 3]
        vals = [leftArm, rightArm, robotHead]
        keyVals = zip keys vals

getPartById :: Int -> Maybe RobotPart
getPartById id = Map.lookup id partsDB

{-- 
    Transform a Maybe Robot into a Maybe Html
    The important part here is that the result will be wrapped also in a Maybe
    even if renderHtml returns Html and not a Maybe Html
--}

partHtml :: Int -> Maybe Html
partHtml partId = renderHtml <$> getPartById partId 

allParts :: [RobotPart]
allParts = map snd (Map.toList partsDB)

allPartsHtml :: [Html]
allPartsHtml = renderHtml <$> allParts

-- For list is more common to use map instead of <$> like this:

allPartsHtml' :: [Html]
allPartsHtml' = map renderHtml allParts

-- This initially seems weird, because basically renderHtml works only with RobotPart
-- and not with Maps of Robots, the thing is that the operator <$> will apply the function 
-- to the values inside the map.
htmlPartsDB :: Map.Map Int Html
htmlPartsDB = renderHtml <$> partsDB

main :: IO ()
main = do
    putStrLn "Functor Sample"
    -- Basic examples of how to apply function to a value contained in a context.
    let incValue = (+1) <$> successFullRequest
    let incValueNothing = (+1) <$> failedRequest
    putStrLn $ show incValue
    putStrLn $ show incValueNothing

