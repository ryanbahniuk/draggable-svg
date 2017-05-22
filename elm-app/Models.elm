module Models exposing (..)

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
  { vertices : List Vertex
  , interactionCounter : Int
  }

initialModel : Model
initialModel =
  { vertices = []
  , interactionCounter = 0
  }

initialVertex : Int -> Coordinates -> Vertex
initialVertex id coordinates =
  Vertex id coordinates False

