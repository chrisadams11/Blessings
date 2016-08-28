module View exposing (..)

import Model exposing (..)
import Html exposing (Html, button, div, text, img, canvas, h1, h3)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List exposing (..)
import String


view : Model -> Html Msg
view model =
    case model of
        Title ->
            drawTitle

        Game gameModel ->
            drawGame gameModel


drawTitle : Html Msg
drawTitle =
    div []
        [ titleBackground
        , titleBanner
        , titleBegin
        ]


titleBackground : Html Msg
titleBackground =
    img
        [ src "assets/title_background.png"
        , style []
        ]
        []


titleBanner : Html Msg
titleBanner =
    divFloatWrapper
        (h1
            [ style
                [ ( "margin-left", "auto" )
                , ( "margin-right", "auto" )
                , ( "margin-top", "300px" )
                , ( "text-align", "center" )
                ]
            ]
            [ text "Blessings" ]
        )


titleBegin : Html Msg
titleBegin =
    divFloatWrapper
        (h3
            [ onClick TitleBegin
            , style
                [ ( "margin-left", "auto" )
                , ( "margin-right", "auto" )
                , ( "margin-top", "500px" )
                , ( "width", "50px" )
                , ( "cursor", "pointer" )
                ]
            ]
            [ text "Begin" ]
        )


divFloatWrapper : Html Msg -> Html Msg
divFloatWrapper elem =
    div
        [ style
            [ ( "position", "absolute" )
            , ( "top", "0" )
            , ( "left", "0" )
            , ( "width", "1600px" )
            , ( "height", "900px" )
            ]
        ]
        [ elem ]


drawGame : GameModel -> Html Msg
drawGame model =
    div [ style [ ( "position", "relative" ) ] ]
        (append
            [ img
                [ src "assets/game_background.png"
                , style
                    [ ( "position", "relative" )
                    , ( "top", "0" )
                    , ( "left", "0" )
                    ]
                ]
                []
            ]
            (foldr
                (\i agg ->
                    (img
                        [ src
                            (if i.isHit then
                                "assets/test_element_hit.png"
                             else
                                "assets/test_element.png"
                            )
                        , onClick (Click i.id)
                        , style
                            [ ( "position", "absolute" )
                            , ( "left", (String.append (toString i.position.x) "px") )
                            , ( "top", (String.append (toString i.position.y) "px") )
                            ]
                        ]
                        []
                    )
                        :: agg
                )
                []
                model.interactables
            )
        )
