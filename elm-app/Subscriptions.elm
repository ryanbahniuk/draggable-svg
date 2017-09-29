port module Subscriptions exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))

port keyPressed : (Int -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
  [ keyPressed KeyPressedResponse
  ]

