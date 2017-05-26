module Animation exposing (..)

import Models exposing (Animations(..))
import Helpers exposing (animationLabel)
import String exposing (append, join)
import List exposing (map)

type alias Keyframe =
  { percent : Int
  , properties : List Property
  }

type alias Property =
  { key : String
  , value : String
  }

keyframes : Animations -> List Keyframe -> String
keyframes animation keyframeList =
  append (append "@keyframes " (animationLabel animation)) (wrapWithBraces (join "\n" (map subBlock keyframeList)))

subBlock : Keyframe -> String
subBlock keyframe =
  append ((toString keyframe.percent) ++ "%") (wrapWithBraces (join "\n" (map blockProperties keyframe.properties)))

blockProperties : Property -> String
blockProperties property =
  property.key ++ ": " ++ property.value ++ ";"

wrapWithBraces : String -> String
wrapWithBraces string =
  " { " ++ string ++ " } "

