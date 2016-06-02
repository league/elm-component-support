module Main exposing (..)

import Html exposing (Html)
import Html.Attributes
import Component.App
import Component.Update as Update
import Messages


main =
    Component.App.program
        { init = Messages.init
        , update = Messages.update
        , view = view
        , subscriptions = Messages.subscriptions
        }


view : Messages.Model -> Html Messages.Msg
view model =
    Html.div [ style ]
        [ Html.h1 [] [ Html.text "Elm echo sample" ]
        , Messages.view model
        ]


style : Html.Attribute msg
style =
    Html.Attributes.style
        [ ( "maxWidth", "300px" )
        , ( "margin", "0px auto" )
        ]
