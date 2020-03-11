module MoneyTest exposing (suite)

import Expect exposing (Expectation)
import Money exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "Money test suite "
        [ test "The value of two euros added." <|
            \() -> Expect.equal (eur 2500) (Money.add (eur 1000) (eur 1500))
        , test "The value of two Usd added." <|
            \() -> Expect.equal (usd 2500) (Money.add (usd 1000) (usd 1500))
        ]
