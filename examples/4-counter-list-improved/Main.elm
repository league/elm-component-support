module Main exposing (..)

import Html exposing (Html)
import Html.Attributes
import Component.App
import CounterList


main =
    Component.App.beginnerProgram
        { init = CounterList.init
        , view = view
        , update = CounterList.update
        }


view : CounterList.Model -> Html CounterList.Msg
view model =
    Html.div [ style ] [ CounterList.view model ]


style : Html.Attribute msg
style =
    Html.Attributes.style
        [ ( "maxWidth", "300px" )
        , ( "margin", "0px auto" )
        ]
