module Main exposing (..)

import Model exposing (..)
import Update exposing (..)
import View exposing (..)
import Html.App as App


-- Main


main : Program Never
main =
    App.program
        { init = ( initModel, Cmd.none )
        , subscriptions = subscriptions
        , view = view
        , update = update
        }



-- Update
-- View
