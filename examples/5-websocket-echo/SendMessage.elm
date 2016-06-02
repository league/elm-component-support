module SendMessage
    exposing
        ( Msg(SendMessage)
        , Model
        , init
        , update
        , view
        )

import Html exposing (..)
import Html.App
import Component.Update as Update
import Button
import TextBox


-- MODEL


type Msg
    = Text TextBox.Msg
    | Send Button.Msg
    | SendClicked
    | SendMessage String


type alias Model =
    { text : TextBox.Model
    , send : Button.Model
    }


init : Model
init =
    { text = TextBox.init "message-text"
    , send = Button.init
    }



-- UPDATE


update : Msg -> Model -> Update.Action Msg Model
update msg model =
    case msg of
        Text (TextBox.EnterPressed) ->
            Update.msg SendClicked

        Text msg' ->
            Update.component msg' model.text (Text) (\x -> { model | text = x }) TextBox.update

        Send (Button.Clicked) ->
            Update.msg SendClicked

        Send msg' ->
            Update.component msg' model.send (Send) (\x -> { model | send = x }) Button.update

        SendClicked ->
            let
                text =
                    TextBox.text model.text
            in
                Update.modelAndEvent { model | text = TextBox.textSetAsEmpty model.text }
                    (SendMessage text)

        SendMessage _ ->
            Update.eventIgnored



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.p [] [ Html.text "Type a message then press Enter or click Send" ]
        , TextBox.view Text model.text "Message to send"
        , Html.App.map Send <| Button.view model.send "Send"
        ]
