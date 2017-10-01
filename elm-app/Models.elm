module Models exposing (..)

type alias Polygon =
  { id : Int
  , vertices : List Vertex
  }

type alias Coordinates =
  { x : Int
  , y : Int
  }

type alias Vertex =
  { id : Int
  , coordinates : Coordinates
  , inFlight : Bool
  }

type alias Model =
  { polygons : List Polygon
  , interactionCounter : Int
  , selectedPolygonId : Maybe Int
  }

initialModel : Model
initialModel =
  { polygons = []
  , interactionCounter = 0
  , selectedPolygonId = Nothing
  }

initialPolygon : Int -> Coordinates -> Polygon
initialPolygon id coordinates =
  Polygon id [(initialVertex id coordinates)]

initialEmptyPolygon : Int -> Polygon
initialEmptyPolygon id =
  Polygon id []

initialVertex : Int -> Coordinates -> Vertex
initialVertex id coordinates =
  Vertex id coordinates False

