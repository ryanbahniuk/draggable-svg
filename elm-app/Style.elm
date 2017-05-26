module Style exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Models exposing (Animations(..))
import Helpers exposing (animationLabel)

type CssClasses
  = Line
  | Circle
  | SecondCircle
  | ThirdCircle
  | StopOne
  | StopTwo

type AnimationTimingFunctions
  = Ease
  | Linear
  | EaseIn
  | EaseOut
  | EaseInOut

css =
  stylesheet
  [ class Line
    [ strokeWidth 2
    ]
  , class Circle
    [ fill turquoise
    , transformOrigin "center center"
    , cursor pointer
    ]
  , class SecondCircle
    [ fill turquoise
    , transform (scale 0.5)
    , transformOrigin "center center"
    , animationName Pulse
    , animationDuration 1.5
    , animationTiming Linear
    , infiniteAnimationIteration
    , animationDelay 0.25
    ]
  , class ThirdCircle
    [ fill turquoise
    , transform (scale 0.5)
    , transformOrigin "center center"
    , animationName Pulse
    , animationDuration 1.5
    , animationTiming Linear
    , infiniteAnimationIteration
    , animationDelay 0.75
    ]
  , class StopOne
    [ stopColor purple
    ]
  , class StopTwo
    [ stopColor green
    ]
  ]

turquoise : Color
turquoise =
  hex "6bdce0"

purple : Color
purple =
  hex "7a5fff"

green : Color
green =
  hex "01ff89"

stopColor : Color -> Mixin
stopColor color =
  property "stop-color" <| (toString color.value)

strokeWidth : Int -> Mixin
strokeWidth width =
  property "stroke-width" <| (toString width)

animationDelay : Float -> Mixin
animationDelay delay =
  property "animation-delay" <| ((toString delay) ++ "s")

infiniteAnimationIteration : Mixin
infiniteAnimationIteration =
  property "animation-iteration-count" <| "infinite"

animationName : Animations -> Mixin
animationName animation =
  property "animation-name" <| (animationLabel animation)

animationTiming : AnimationTimingFunctions -> Mixin
animationTiming function =
  property "animation-timing-function" <| (timingFunction function)

timingFunction : AnimationTimingFunctions -> String
timingFunction function =
  case function of
    Ease -> "ease"
    Linear -> "linear"
    EaseIn -> "ease-in"
    EaseOut -> "ease-out"
    EaseInOut -> "ease-in-out"

animationDuration : Float -> Mixin
animationDuration duration =
  property "animation-duration" <| ((toString duration) ++ "s")

transformOrigin : String -> Mixin
transformOrigin value =
  property "transform-origin" <| value
