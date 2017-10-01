module Helpers exposing (..)

import List exposing (any, all, map)
import Models exposing (Polygon, Vertex)

anyInFlight : List Polygon -> Bool
anyInFlight polygons =
  any anyVertexInFlight (map (\n -> n.vertices) polygons)

anyVertexInFlight : List Vertex -> Bool
anyVertexInFlight vertices =
  any isInFlight vertices

noneInFlight : List Polygon -> Bool
noneInFlight polygons =
  all noVertexInFlight (map (\n -> n.vertices) polygons)

noVertexInFlight : List Vertex -> Bool
noVertexInFlight vertices =
  all (\n -> (isNotInFlight n)) vertices

isInFlight : Vertex -> Bool
isInFlight vertex =
  vertex.inFlight

isNotInFlight : Vertex -> Bool
isNotInFlight vertex =
  not (isInFlight vertex)

