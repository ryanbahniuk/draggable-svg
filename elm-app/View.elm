module View exposing (..)

import List exposing (map, length)
import String exposing (join)
import Svg exposing (Svg, svg, g, defs, polyline, circle, linearGradient, stop, animate)
import Svg.Events exposing (onMouseUp)
import Svg.Attributes exposing (cx, cy, r, x1, y1, x2, y2, width, height, viewBox, offset, fill, id, class, attributeName, values, dur, repeatCount, points, stroke)
import Models exposing (Model, Vertex, Coordinates)
import Messages exposing (Msg(..))
import Events exposing (onMouseMove, onClick, onStopPropClick, onStopPropMouseDown)
import Helpers exposing (noneInFlight)

view : Model -> Svg Msg
view model =
  svg [ width "1000", height "1000", viewBox "0 0 1000 1000", clickAction model, onMouseMove Track, onMouseUp Lock ]
  [ gradient
  , polylineView model.vertices
  , g [] (map circleView model.vertices)
  ]

clickAction : Model -> Svg.Attribute Msg
clickAction model =
  if (noneInFlight model.vertices) then
    onClick Add
  else
    onStopPropClick Noop

gradient : Svg Msg
gradient =
  defs []
  [ linearGradient [ id "gradient", x1 "0%", y1 "0%", x2 "100%", y2 "0%" ]
    [ stop [ offset "0%", class "stop-one" ]
      [ animate [ attributeName "stop-color", values "#7A5FFF; #01FF89; #7A5FFF", dur "4s", repeatCount "indefinite" ] []
      ]
    , stop [ offset "100%", class "stop-two" ]
      [ animate [ attributeName "stop-color", values "#01FF89; #7A5FFF; #01FF89", dur "4s", repeatCount "indefinite" ] []
      ]
    ]
  ]

polylineView : List Vertex -> Svg Msg
polylineView vertices =
  polyline [ fill "url(#gradient)", polylineStroke vertices, class "line", points (polyPoints (map .coordinates vertices)) ] []

polylineStroke : List Vertex -> Svg.Attribute Msg
polylineStroke vertices =
  if (length vertices) > 2 then
    stroke "none"
  else
    stroke "#6bdce0"

polyPoints : List Coordinates -> String
polyPoints coordinates =
  join " " (map (\n -> (toString n.x) ++ "," ++ (toString n.y)) coordinates)

circleView : Vertex -> Svg Msg
circleView vertex =
  g []
  [ circle [ cx (toString vertex.coordinates.x), cy (toString vertex.coordinates.y), r "10", class "third-circle" ] []
  , circle [ cx (toString vertex.coordinates.x), cy (toString vertex.coordinates.y), r "10", class "second-circle" ] []
  , circle [ cx (toString vertex.coordinates.x), cy (toString vertex.coordinates.y), r "10", class "circle", onStopPropMouseDown (Unlock vertex) ] []
  ]
