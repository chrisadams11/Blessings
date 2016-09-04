module Update exposing (..)

import Model exposing (..)
import Time exposing (..)
import List exposing (..)


subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        Game gameModel ->
            every (millisecond * 30) Tick

        _ ->
            Sub.none


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case model of
        Title ->
            updateTitle msg

        Game gameModel ->
            updateGame msg gameModel


updateTitle : Msg -> ( Model, Cmd msg )
updateTitle msg =
    case msg of
        TitleBegin ->
            ( initGameModel, Cmd.none )

        _ ->
            ( Title, Cmd.none )


updateGame : Msg -> GameModel -> ( Model, Cmd msg )
updateGame msg game =
    case msg of
        -- Main game loop
        Tick time ->
            let
                updatedInputState =
                    updateInputState game.inputState game.inputFrame

                updatedGameState =
                    updateGameState game.gameState updatedInputState

                updatedDrawState =
                    updateDrawState game.drawState game.gameState game.inputState
            in
                ( Game
                    { game
                        | inputFrame = newInputFrame
                        , inputState = updatedInputState
                        , gameState = updatedGameState
                        , drawState = updatedDrawState
                    }
                , Cmd.none
                )

        -- Input messages
        Click interactableID ->
            ( Game { game | inputFrame = interact game.inputFrame interactableID }, Cmd.none )

        Space ->
            ( Game { game | inputFrame = pause game.inputFrame }, Cmd.none )

        _ ->
            ( Game game, Cmd.none )


updateInputState : InputState -> InputFrame -> InputState
updateInputState inputState inputFrame =
    { inputState
        | interactions = inputFrame.interactions
        , pause = inputFrame.pause
        , timer = inputState.timer + 1
    }


updateGameState : GameState -> InputState -> GameState
updateGameState gameState inputState =
    let
        updatedPauseState =
            if inputState.pause then
                (not gameState.paused)
            else
                gameState.paused

        updatedInteractables =
            map
                (\i ->
                    if member i.id inputState.interactions then
                        { i | isHit = True }
                    else
                        i
                )
                gameState.interactables
    in
        { gameState | interactables = updatedInteractables, paused = updatedPauseState }


updateDrawState : DrawState -> GameState -> InputState -> DrawState
updateDrawState drawState gameState inputState =
    { paused = gameState.paused
    , interactables = gameState.interactables
    }


interact : InputFrame -> InteractableID -> InputFrame
interact inputFrame interactableID =
    { inputFrame | interactions = interactableID :: inputFrame.interactions }


pause : InputFrame -> InputFrame
pause inputFrame =
    { inputFrame | pause = True }
