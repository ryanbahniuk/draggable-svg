module Messages exposing (..)

import Models exposing (Coordinates, Vertex)

type Msg
  = Add Coordinates
  | Unlock Vertex
  | Lock
  | Track Coordinates
  | Noop

