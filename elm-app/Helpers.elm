module Helpers exposing (..)

import List exposing (any, all)
import Models exposing (Vertex)

anyInFlight : List Vertex -> Bool
anyInFlight vertices =
  any isInFlight vertices

noneInFlight : List Vertex -> Bool
noneInFlight vertices =
  all (\n -> (isNotInFlight n)) vertices

isInFlight : Vertex -> Bool
isInFlight vertex =
  vertex.inFlight

isNotInFlight : Vertex -> Bool
isNotInFlight vertex =
  not (isInFlight vertex)

