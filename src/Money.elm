module Money exposing (CurrencyCode(..), Money, add, eur, moneyToString, usd)

-- Money is an abstraction of some amount of money in a Money.


type alias Money =
    { amount : Int
    , currencyCode : CurrencyCode
    }


type CurrencyCode
    = Eur
    | Usd
    | Yen


eur : Int -> Money
eur amount =
    Money amount Eur


usd : Int -> Money
usd amount =
    Money amount Usd


moneyToString : Money -> String
moneyToString money =
    case money.currencyCode of
        Eur ->
            moneyToStringHelper money.amount 100.0 " EUR"

        Usd ->
            moneyToStringHelper money.amount 100.0 " USD"

        Yen ->
            moneyToStringHelper money.amount 1 " YEN"


moneyToStringHelper amount scale name =
    String.fromFloat (toFloat amount / scale) ++ name


add : Money -> Money -> Money
add m1 m2 =
    let
        rate =
            exchangeRate m1.currencyCode m2.currencyCode

        newAmount =
            round (rate * toFloat m1.amount + toFloat m2.amount)
    in
    Money newAmount m2.currencyCode


exchangeRate : CurrencyCode -> CurrencyCode -> Float
exchangeRate c1 c2 =
    case ( c1, c2 ) of
        _ ->
            1.0
