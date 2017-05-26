module Helpers exposing (..)

import List exposing (any, all)
import Models exposing (Vertex, Animations(..))

anyInFlight : List Vertex -> Bool
anyInFlight vertices =
  any (\n -> (n.inFlight == True)) vertices

noneInFlight : List Vertex -> Bool
noneInFlight vertices =
  all (\n -> (n.inFlight == False)) vertices

animationLabel : Animations -> String
animationLabel animation =
  case animation of
    Pulse -> "pulse"


