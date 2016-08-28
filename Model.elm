module Model exposing (..)

import Time exposing (..)


type Msg
    = Click InteractableID
    | Space
    | TitleBegin
    | Tick Time


type alias InteractableID =
    String


type alias Resource =
    String


type alias Vector =
    { x : Int
    , y : Int
    }


type alias Interactable =
    { id : InteractableID
    , isHit : Bool
    , position : Vector
    }


type Model
    = Title
    | Game GameModel


type alias GameModel =
    { interactables : List Interactable
    , paused : Bool
    , timer : Int
    }


initModel : Model
initModel =
    Title


initGameModel : Model
initGameModel =
    Game
        { interactables =
            [ { id = "test1"
              , isHit = False
              , position = { x = 10, y = 20 }
              }
            , { id = "test2"
              , isHit = False
              , position = { x = 100, y = 200 }
              }
            ]
        , paused = False
        , timer = 0
        }
