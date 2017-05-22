module Helpers exposing (..)

import List exposing (any, all)
import Models exposing (Vertex)

anyInFlight : List Vertex -> Bool
anyInFlight vertices =
  any (\n -> (n.inFlight == True)) vertices

noneInFlight : List Vertex -> Bool
noneInFlight vertices =
  all (\n -> (n.inFlight == False)) vertices

