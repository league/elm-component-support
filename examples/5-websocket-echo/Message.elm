module Message
    exposing
        ( Msg
        , Model
        , init
        , update
        , view
        )

import Html exposing (Html)
import Html.Attributes
import Html.Events exposing (onMouseEnter, onMouseLeave)
import Component.Update as Update


-- MODEL


type Msg
    = MouseEnter
    | MouseLeave


type alias Model =
    { hover : Bool
    , text : String
    }


init : String -> Model
init text =
    { hover = False
    , text = text
    }



-- UPDATE


update : Msg -> Model -> Update.Action Msg Model
update msg model =
    case msg of
        MouseEnter ->
            Update.model { model | hover = True }

        MouseLeave ->
            Update.model { model | hover = False }



-- VIEW


view : Model -> Html Msg
view model =
    Html.div
        [ onMouseEnter MouseEnter
        , onMouseLeave MouseLeave
        , Html.Attributes.style
            [ ( "backgroundColor"
              , if model.hover then
                    "#eee"
                else
                    "transparent"
              )
            , ( "borderBottom", "solid 1px rgba(0,0,0,.12)" )
            , ( "padding", "4px" )
            ]
        ]
        [ Html.text model.text ]
