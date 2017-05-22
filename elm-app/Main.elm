module Main exposing (..)

import Html.App exposing (beginnerProgram)
import Models exposing (initialModel)
import View exposing (view)
import Update exposing (update)

main =
  beginnerProgram { model = initialModel, view = view, update = update }

