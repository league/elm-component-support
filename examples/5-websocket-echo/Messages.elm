module Messages
    exposing
        ( Msg
        , Model
        , init
        , update
        , subscriptions
        , view
        )

import Html exposing (Html)
import Html.App
import Html.Attributes
import WebSocket
import SendMessage as Sender
import Component.Update as Update
import Message


-- MODEL


type Msg
    = Sender Sender.Msg
    | ReceiveMessage String
    | Message ID Message.Msg


type alias Model =
    { sender : Sender.Model
    , messages : List ( ID, Message.Model )
    , nextID : ID
    }


type alias ID =
    Int


init : Model
init =
    { sender = Sender.init
    , messages = []
    , nextID = 0
    }



-- WEBSOCKET


echoServer : String
echoServer =
    "ws://echo.websocket.org"



-- UPDATE


update : Msg -> Model -> Update.Action Msg Model
update msg model =
    case msg of
        Sender (Sender.SendMessage message) ->
            Update.cmd (WebSocket.send echoServer message)

        Sender msg' ->
            Update.component msg' model.sender (Sender) (\x -> { model | sender = x }) Sender.update

        ReceiveMessage text ->
            let
                id =
                    model.nextID

                message =
                    Message.init text
            in
                Update.model
                    { model
                        | messages = ( id, message ) :: model.messages
                        , nextID = model.nextID + 1
                    }

        Message id msg' ->
            Update.components id msg' model.messages (Message id) (\x -> { model | messages = x }) Message.update



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen echoServer ReceiveMessage



-- VIEW


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.App.map Sender <| Sender.view model.sender
        , Html.div [] (List.map viewMessage (List.reverse model.messages))
        ]


viewMessage : ( ID, Message.Model ) -> Html Msg
viewMessage ( id, message ) =
    Html.App.map (Message id) <| Message.view message
