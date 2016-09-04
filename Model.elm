module Model exposing (..)

import Time exposing (..)


type Msg
    = Click InteractableID
    | Space
    | TitleBegin
    | Tick Time


type alias InputFrame =
    { interactions : List InteractableID
    , pause : Bool
    }


type alias InputState =
    { interactions : List InteractableID
    , pause : Bool
    , timer : Int
    }


type alias GameState =
    { interactables : List Interactable
    , paused : Bool
    }


type alias DrawState =
    { interactables : List Interactable
    , paused : Bool
    }


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
    { inputFrame : InputFrame
    , inputState : InputState
    , gameState : GameState
    , drawState : DrawState
    }


newInputFrame : InputFrame
newInputFrame =
    { interactions = []
    , pause = False
    }


initModel : Model
initModel =
    Title


initGameModel : Model
initGameModel =
    Game
        { inputFrame = newInputFrame
        , inputState =
            { interactions = []
            , pause = False
            , timer = 0
            }
        , gameState =
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
            }
        , drawState =
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
            }
        }
