module Update exposing (..)

import Model exposing (..)
import Time exposing (..)
import List exposing (..)


subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        Game gameModel ->
            every second Tick

        _ ->
            Sub.none


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case model of
        Title ->
            case msg of
                TitleBegin ->
                    ( initGameModel, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        Game gameModel ->
            case msg of
                Click interactableID ->
                    ( Game (interact gameModel interactableID), Cmd.none )

                Space ->
                    ( Game (pauseGame gameModel), Cmd.none )

                Tick time ->
                    if gameModel.timer < 10 then
                        ( Game { gameModel | timer = gameModel.timer + 1 }, Cmd.none )
                    else
                        ( Title, Cmd.none )

                _ ->
                    ( model, Cmd.none )


interact : GameModel -> InteractableID -> GameModel
interact model interactableID =
    let
        newInteractables =
            map
                (\interactable ->
                    if interactable.id == interactableID then
                        { interactable | isHit = True }
                    else
                        interactable
                )
                model.interactables
    in
        { model | interactables = newInteractables }


pauseGame : GameModel -> GameModel
pauseGame model =
    { model | paused = True }
