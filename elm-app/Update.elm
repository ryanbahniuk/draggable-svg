module Update exposing (..)

import List exposing (map, append)
import Models exposing (Model, Vertex, Coordinates, initialVertex)
import Messages exposing (Msg(..))
import Helpers exposing (anyInFlight)

update : Msg -> Model -> Model
update msg model =
  case msg of
    Noop ->
      model

    Add coordinates ->
      if (anyInFlight model.vertices) then
        model
      else
        { model | vertices = (append model.vertices [(initialVertex model.interactionCounter coordinates)]), interactionCounter = model.interactionCounter + 1 }

    Unlock vertex ->
      { model | vertices = (unlockVertex model.vertices vertex) }

    Lock ->
      { model | vertices = (lockAllVertices model.vertices) }

    Track coordinates ->
      { model | vertices = (updateInFlightVertex model.vertices coordinates) }

updateInFlightVertex : List Vertex -> Coordinates -> List Vertex
updateInFlightVertex vertices coordinates =
  map (updateVertexCoordinates coordinates) vertices

unlockVertex : List Vertex -> Vertex -> List Vertex
unlockVertex vertices vertex =
  map (updateVertexInFlight vertex.id) vertices

lockAllVertices : List Vertex -> List Vertex
lockAllVertices vertices =
  map lockVertex vertices

lockVertex : Vertex -> Vertex
lockVertex vertex =
  { vertex | inFlight = False }

updateVertexCoordinates : Coordinates -> Vertex -> Vertex
updateVertexCoordinates coordinates vertex =
  if (vertex.inFlight) then
    { vertex | coordinates = coordinates }
  else
    vertex

updateVertexInFlight : Int -> Vertex -> Vertex
updateVertexInFlight id vertex =
  if (id == vertex.id) then
    { vertex | inFlight = True }
  else
    vertex
