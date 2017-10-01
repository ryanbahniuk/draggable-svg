module Messages exposing (..)

import Models exposing (Polygon, Coordinates, Vertex)

type Msg
  = Add Coordinates
  | Unlock Polygon Vertex
  | Lock
  | Track Coordinates
  | KeyPressedResponse Int
  | Noop

