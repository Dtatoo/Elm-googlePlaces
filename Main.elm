port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (id)


type alias Model =
    { result : String }


type Msg
    = PlaceResult String


port initSearch : Model -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlaceResult result ->
            ( { model | result = result }, Cmd.none )


init : ( Model, Cmd Msg )
init =
    ( Model "", initSearch (Model "") )



-- SUBSCRIPTIONS


port placeSuggestion : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    placeSuggestion PlaceResult



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [ id "placesearch" ] []
        , div [] [ text <| String.concat [ "Result is..", model.result ] ]
        ]


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
