module Button exposing (Msg(Clicked), Model, init, update, view)

import Html exposing (Html, button, text)
import Html.App
import Html.Attributes exposing (disabled)
import Html.Events exposing (onClick)
import Component.Update as Update


-- MODEL


type Msg
    = Click
      -- public messages
    | Clicked


type alias Model =
    { disabled : Bool }


init : Model
init =
    { disabled = False }


enable : Model -> Model
enable model =
    { model | disabled = False }


disable : Model -> Model
disable model =
    { model | disabled = True }



-- UPDATE


update : Msg -> Model -> Update.Action Msg Model
update msg model =
    case msg of
        Click ->
            Update.event Clicked

        Clicked ->
            Update.eventIgnored



-- VIEW


view : Model -> String -> Html Msg
view model title =
    viewWithContent model [ text title ]


viewWithContent : Model -> List (Html Msg) -> Html Msg
viewWithContent model content =
    let
        attributes =
            [ onClick Click
            , disabled model.disabled
            ]
    in
        button attributes content
