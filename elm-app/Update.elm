module Update exposing (..)

import List exposing (head, map, append, filter, length)
import Models exposing (Model, Polygon, Vertex, Coordinates, initialVertex, initialPolygon, initialEmptyPolygon)
import Messages exposing (Msg(..))
import Helpers exposing (anyInFlight, isNotInFlight, anyVertexInFlight)
import String exposing (join)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Noop ->
      ( model, Cmd.none )

    Add coordinates ->
      if (anyInFlight model.polygons) then
        ( model, Cmd.none )
      else
        case model.selectedPolygonId of
          Just selectedPolygonId ->
            ( { model | polygons = (updateSelectedPolygonWithNewVertex model.polygons selectedPolygonId coordinates model.interactionCounter), interactionCounter = model.interactionCounter + 1 }, Cmd.none )
          Nothing ->
            let
              newPolygon = (initialPolygon model.interactionCounter coordinates)
            in
              ( { model | polygons = (append model.polygons [newPolygon]), selectedPolygonId = Just newPolygon.id, interactionCounter = model.interactionCounter + 1 }, Cmd.none )

    Unlock polygon vertex ->
      ( { model | polygons = (unlockVertex model.polygons polygon vertex) }, Cmd.none )

    Lock ->
      ( { model | polygons = (lockAllVertices model.polygons) }, Cmd.none )

    Track coordinates ->
      ( { model | polygons = (updateInFlightVertex model.polygons coordinates) }, Cmd.none )

    KeyPressedResponse key ->
      if key == 8 then
        case (selectedPolygon model.polygons model.selectedPolygonId) of
          Just selectedPolygon ->
            if (anyVertexInFlight selectedPolygon.vertices) then
              if (length selectedPolygon.vertices == 1) then
                ( { model | polygons = (deletePolygonWithInFlightVertex model.polygons), selectedPolygonId = Nothing }, Cmd.none )
              else
                ( { model | polygons = (deleteInFlightVertex model.polygons) }, Cmd.none )
            else
              ( model, Cmd.none )
          Nothing ->
            ( model, Cmd.none )
      else if key == 13 then
        let
          newPolygon = (initialEmptyPolygon model.interactionCounter)
        in
          ( { model | polygons = (append model.polygons [newPolygon]), selectedPolygonId = Just newPolygon.id, interactionCounter = model.interactionCounter + 1 }, Cmd.none )
      else
        ( model, Cmd.none )

selectedPolygon : List Polygon -> Maybe Int -> Maybe Polygon
selectedPolygon polygons maybeId =
  case maybeId of
    Just id -> head (filter (\n -> n.id == id) polygons)
    Nothing -> Nothing

updateSelectedPolygonWithNewVertex : List Polygon -> Int -> Coordinates -> Int -> List Polygon
updateSelectedPolygonWithNewVertex polygons selectedPolygonId coordinates interactionCounter =
  map (addVertexIfSelected selectedPolygonId coordinates interactionCounter) polygons

addVertexIfSelected : Int -> Coordinates -> Int -> Polygon -> Polygon
addVertexIfSelected selectedPolygonId coordinates interactionCounter polygon =
  if polygon.id == selectedPolygonId then
     { polygon | vertices = (append polygon.vertices [(initialVertex interactionCounter coordinates)]) }
  else
    polygon

deletePolygonWithInFlightVertex : List Polygon -> List Polygon
deletePolygonWithInFlightVertex polygons =
  filter (\n -> (not (anyVertexInFlight n.vertices))) polygons

deleteInFlightVertex : List Polygon -> List Polygon
deleteInFlightVertex polygons =
  map (\n -> { n | vertices = (filter isNotInFlight n.vertices) }) polygons

updateInFlightVertex : List Polygon -> Coordinates -> List Polygon
updateInFlightVertex polygons coordinates =
  map (updatePolygonCoordinates coordinates) polygons

updatePolygonCoordinates : Coordinates -> Polygon -> Polygon
updatePolygonCoordinates coordinates polygon =
  { polygon | vertices = (map (updateVertexCoordinates coordinates) polygon.vertices) }

unlockVertex : List Polygon -> Polygon -> Vertex -> List Polygon
unlockVertex polygons selectedPolygon selectedVertex =
  map (updateVerticesInPolygon selectedPolygon selectedVertex) polygons

updateVerticesInPolygon : Polygon -> Vertex -> Polygon -> Polygon
updateVerticesInPolygon selectedPolygon selectedVertex polygon =
  if polygon.id == selectedPolygon.id then
    { polygon | vertices = (map (updateVertexInPolygon selectedVertex) polygon.vertices) }
  else
    polygon

updateVertexInPolygon : Vertex -> Vertex -> Vertex
updateVertexInPolygon selectedVertex vertex =
  if vertex.id == selectedVertex.id then
    { vertex | inFlight = True }
  else
    vertex

lockAllVertices : List Polygon -> List Polygon
lockAllVertices polygons =
  map (\n -> { n | vertices = (map lockVertex n.vertices) }) polygons

lockVertex : Vertex -> Vertex
lockVertex vertex =
  { vertex | inFlight = False }

updateVertexCoordinates : Coordinates -> Vertex -> Vertex
updateVertexCoordinates coordinates vertex =
  if (vertex.inFlight) then
    { vertex | coordinates = coordinates }
  else
    vertex

