module Events exposing (..)

import Svg exposing (Attribute)
import Html.Events exposing (keyCode)
import Svg.Events exposing (on)
import Json.Decode exposing (succeed, map)
import VirtualDom exposing (Options, onWithOptions)
import Models exposing (Coordinates)
import Decoders exposing (coordinateDecoder)

onClick : (Coordinates -> msg) -> Attribute msg
onClick message =
  on "mousedown" (map message coordinateDecoder)

onMouseMove : (Coordinates -> msg) -> Attribute msg
onMouseMove message =
  on "mousemove" (map message coordinateDecoder)

onStopPropMouseDown : msg -> Attribute msg
onStopPropMouseDown message =
  onWithOptions "mousedown" stopPropOptions (succeed message)

onStopPropMouseUp : msg -> Attribute msg
onStopPropMouseUp message =
  onWithOptions "mouseup" stopPropOptions (succeed message)

onStopPropClick : msg -> Attribute msg
onStopPropClick message =
  onWithOptions "mousedown" stopPropOptions (succeed message)

stopPropOptions : Options
stopPropOptions =
  { stopPropagation = True
  , preventDefault = False
  }

