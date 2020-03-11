module Main exposing (Model, Msg(..), init, initialModel, main)

import Browser
import Catalog exposing (CatalogItem, catalogItems)
import Html exposing (Html, button, div, h1, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Money exposing (..)
import ShoppingCart exposing (ShoppingCart, ShoppingCartItem, addItem)


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type Msg
    = AddToCart CatalogItem


type alias Model =
    { hello : String
    , cart : ShoppingCart
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { hello = "Hello World"
    , cart = ShoppingCart []
    }



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddToCart catalogItem ->
            ( { model | cart = addItem model.cart catalogItem }, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    div [ class "row" ]
        [ viewCatalog
        , viewCart model.cart
        ]


viewCatalog : Html Msg
viewCatalog =
    div [ class "col" ]
        [ h1 [] [ text "Catalog" ]
        , viewCatalogItems
        ]


viewCatalogItems : Html Msg
viewCatalogItems =
    table []
        [ thead []
            [ tr [] [ th [] [ text "Description" ], th [] [ text "Price" ], th [] [ text "Add" ] ]
            ]
        , tbody [] (List.map viewCatalogItem catalogItems)
        ]


viewCatalogItem : CatalogItem -> Html Msg
viewCatalogItem item =
    tr []
        [ td [] [ text item.description ]
        , td [] [ text <| moneyToString item.price ]
        , td [] [ button [ onClick (AddToCart item) ] [ text "Add" ] ]
        ]


viewCart : ShoppingCart -> Html Msg
viewCart cart =
    div [ class "cart" ]
        [ div [] [ text "Shopping cart" ]
        , text <| "Number of items in cart: " ++ (String.fromInt <| List.sum <| List.map .quantity cart.items)
        , viewCartItems cart
        ]


viewCartItems : ShoppingCart -> Html Msg
viewCartItems cart =
    table []
        [ thead []
            [ tr []
                [ th [] [ text "Description" ]
                , th [] [ text "Price" ]
                , th [ class "quantity" ] [ text "Quantity" ]
                , th [ class "total" ] [ text "Total" ]
                ]
            ]
        , tbody [] (List.map viewCartItem cart.items)
        ]


viewCartItem : ShoppingCartItem -> Html Msg
viewCartItem item =
    tr []
        [ td [] [ text item.description ]
        , td [] [ text <| moneyToString item.price ]
        , td [ class "quantity" ] [ text <| String.fromInt item.quantity ]
        , td [ class "total" ] [ text <| moneyToString (itemPrice item.quantity item.price) ]
        ]


itemPrice : Int -> Money -> Money
itemPrice quantity price =
    { amount = price.amount * quantity
    , currencyCode = price.currencyCode
    }



-- Subscription


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
