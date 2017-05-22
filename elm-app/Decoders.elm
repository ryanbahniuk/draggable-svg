module Decoders exposing (..)

import Json.Decode exposing (Decoder, int)
import Json.Decode.Pipeline exposing (decode, required)
import Models exposing (Coordinates)

coordinateDecoder : Decoder Coordinates
coordinateDecoder =
  decode Coordinates
  |> required "pageX" int
  |> required "pageY" int

