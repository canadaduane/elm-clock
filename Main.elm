module Main exposing (..)

import Html.App as App
import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Time exposing (every, second, millisecond)
import Clock exposing (clock)


type alias Time =
    Int


type TimeMode
    = SlowTimeMode
    | FastTimeMode


type Msg
    = Tick Float
    | ResetTime
    | ToggleTimeMode


{-| time is kept as the number of minutes since midnight
-}
type alias Model =
    { currentTime : Time
    , destinationTime : Time
    , timeMode : TimeMode
    }


initialModel : Model
initialModel =
    { currentTime = 0
    , destinationTime = 360
    , timeMode = SlowTimeMode
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.timeMode of
        SlowTimeMode ->
            every second Tick

        FastTimeMode ->
            every millisecond Tick


view : Model -> Html Msg
view model =
    div []
        [ clock model.currentTime
        , button [ onClick ToggleTimeMode ] [ text "Toggle Time Mode" ]
        , button [ onClick ResetTime ] [ text "Reset Time" ]
        ]


init : ( Model, Cmd a )
init =
    ( initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd a )
update msg model =
    let
        newModel =
            case msg of
                Tick time ->
                    if model.currentTime < model.destinationTime then
                        { model | currentTime = model.currentTime + 1 }
                    else if model.currentTime > model.destinationTime then
                        { model | currentTime = model.currentTime - 1 }
                    else
                        model

                ToggleTimeMode ->
                    case model.timeMode of
                        SlowTimeMode ->
                            { model | timeMode = FastTimeMode }

                        FastTimeMode ->
                            { model | timeMode = SlowTimeMode }

                ResetTime ->
                    { model | currentTime = 0 }
    in
        ( newModel, Cmd.none )


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
