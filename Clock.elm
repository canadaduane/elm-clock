module Clock exposing (clock)

import Html exposing (Html)
import Svg exposing (svg, line, circle)
import Svg.Attributes exposing (..)


type alias Time =
    Int


type alias Angle =
    Float


pi =
    3.14159


two_pi =
    pi * 2


half_pi =
    pi / 2


hourHandAngle : Time -> Angle
hourHandAngle time =
    (toFloat time) / 60 / 12 * two_pi - half_pi


minuteHandAngle : Time -> Angle
minuteHandAngle time =
    (toFloat (time % 60)) / 60 * two_pi - half_pi


clock : Time -> Html a
clock time =
    let
        cx' =
            200

        cy' =
            200

        r' =
            200

        bigHandAngle =
            hourHandAngle time

        bigHandX =
            cx' + (cos bigHandAngle) * (r' - 20)

        bigHandY =
            cy' + (sin bigHandAngle) * (r' - 20)

        littleHandAngle =
            minuteHandAngle time

        littleHandX =
            cx' + (cos littleHandAngle) * (r' - 20)

        littleHandY =
            cy' + (sin littleHandAngle) * (r' - 20)
    in
        svg
            [ width (toString <| cx' * 2)
            , height (toString <| cy' * 2)
            , viewBox ("-5 -5 " ++ (toString (cx' * 2 + 10)) ++ " " ++ (toString (cy' * 2 + 10)))
            ]
            [ circle
                [ cx (toString cx')
                , cy (toString cy')
                , r (toString r')
                , fillOpacity "0"
                , strokeWidth "2"
                , stroke "#888"
                ]
                []
            , line
                {- Big Hand -}
                [ x1 (toString cx')
                , y1 (toString cy')
                , x2 (toString bigHandX)
                , y2 (toString bigHandY)
                , strokeWidth "5"
                , stroke "#555"
                , strokeLinecap "round"
                ]
                []
            , line
                {- Little Hand -}
                [ x1 (toString cx')
                , y1 (toString cy')
                , x2 (toString littleHandX)
                , y2 (toString littleHandY)
                , strokeWidth "3"
                , stroke "#999"
                , strokeLinecap "round"
                ]
                []
            ]
