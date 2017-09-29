module Update exposing (..)

import List exposing (map, append, filter)
import Models exposing (Model, Vertex, Coordinates, initialVertex)
import Messages exposing (Msg(..))
import Helpers exposing (anyInFlight, isNotInFlight)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Noop ->
      ( model, Cmd.none )

    Add coordinates ->
      if (anyInFlight model.vertices) then
        ( model, Cmd.none )
      else
        ( { model | vertices = (append model.vertices [(initialVertex model.interactionCounter coordinates)]), interactionCounter = model.interactionCounter + 1 }, Cmd.none )

    Unlock vertex ->
      ( { model | vertices = (unlockVertex model.vertices vertex) }, Cmd.none )

    Lock ->
      ( { model | vertices = (lockAllVertices model.vertices) }, Cmd.none )

    Track coordinates ->
      ( { model | vertices = (updateInFlightVertex model.vertices coordinates) }, Cmd.none )

    KeyPressedResponse key ->
      if key == 8 then
        ( { model | vertices = (deleteInFlightVertex model.vertices) }, Cmd.none )
      else
        ( model, Cmd.none )

deleteInFlightVertex : List Vertex -> List Vertex
deleteInFlightVertex vertices =
  filter isNotInFlight vertices

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
