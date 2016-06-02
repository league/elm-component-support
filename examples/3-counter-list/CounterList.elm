module CounterList
    exposing
        ( Msg
        , Model
        , init
        , update
        , view
        )

import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Component.Update as Update
import Counter


-- MODEL


type Msg
    = Insert
    | Remove
    | Counter ID Counter.Msg


type alias Model =
    { counters : List ( ID, Counter.Model )
    , nextID : ID
    }


type alias ID =
    Int


init : Model
init =
    { counters = []
    , nextID = 0
    }



-- UPDATE


update : Msg -> Model -> Update.Action Msg Model
update msg' model =
    case msg' of
        Insert ->
            let
                newCounter =
                    ( model.nextID, Counter.init 0 )

                newCounters =
                    model.counters ++ [ newCounter ]
            in
                Update.model
                    { model
                        | counters = newCounters
                        , nextID = model.nextID + 1
                    }

        Remove ->
            Update.model { model | counters = List.drop 1 model.counters }

        Counter id msg ->
            Update.components id msg model.counters (Counter id) (\x -> { model | counters = x }) Counter.update



-- VIEW


view : Model -> Html Msg
view model =
    let
        counters =
            List.map viewCounter model.counters

        remove =
            button [ onClick Remove ] [ text "Remove" ]

        insert =
            button [ onClick Insert ] [ text "Add" ]
    in
        div [] ([ remove, insert ] ++ counters)


viewCounter : ( ID, Counter.Model ) -> Html Msg
viewCounter ( id, model ) =
    Html.App.map (Counter id) <| Counter.view model
