module CounterList
    exposing
        ( Msg
        , Model
        , init
        , update
        , view
        )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Component.Update as Update
import Counter


-- MODEL


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


type Msg
    = Insert
    | Remove ID
    | Counter ID Counter.Msg


update : Msg -> Model -> Update.Action Msg Model
update msg' model =
    case msg' of
        Insert ->
            Update.model
                { model
                    | counters = model.counters ++ [ ( model.nextID, Counter.init 0 ) ]
                    , nextID = model.nextID + 1
                }

        Remove id ->
            Update.model
                { model
                    | counters = List.filter (\( x, _ ) -> x /= id) model.counters
                }

        Counter id msg ->
            Update.components id msg model.counters (Counter id) (\x -> { model | counters = x }) Counter.update



-- VIEW


view : Model -> Html Msg
view model =
    let
        counters =
            List.map viewCounter model.counters

        insert =
            button [ onClick Insert ] [ text "Add" ]
    in
        div [] (insert :: counters)


viewCounter : ( ID, Counter.Model ) -> Html Msg
viewCounter ( id, model ) =
    let
        remove =
            button [ onClick <| Remove id ] [ text "Remove" ]
    in
        Counter.viewWithButtons (Counter id) model [ remove ]
