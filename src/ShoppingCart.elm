module ShoppingCart exposing (ShoppingCart, ShoppingCartItem, addItem, cartValue, itemPrice, removeItem)

import Money exposing (Money, eur)


type alias ShoppingCart =
    { items : List ShoppingCartItem
    }


type alias ShoppingCartItem =
    { id : Int
    , description : String
    , price : Money
    , quantity : Int
    }


type alias SomeItem a =
    { a
        | id : Int
        , description : String
        , price : Money
    }


addItem : ShoppingCart -> SomeItem a -> ShoppingCart
addItem cart item =
    { cart | items = changeQuantity cart.items item 1 }


removeItem : ShoppingCart -> SomeItem a -> ShoppingCart
removeItem cart item =
    { cart | items = changeQuantity cart.items item -1 }


itemPrice : ShoppingCartItem -> Money
itemPrice item =
    { amount = item.price.amount * item.quantity
    , currencyCode = item.price.currencyCode
    }


cartValue : ShoppingCart -> Money
cartValue cart =
    List.map itemPrice cart.items |> List.foldl Money.add (eur 0)


changeQuantity : List ShoppingCartItem -> SomeItem a -> Int -> List ShoppingCartItem
changeQuantity list item change =
    case list of
        [] ->
            [ { id = item.id, description = item.description, price = item.price, quantity = 1 } ]

        head :: tail ->
            if head.id == item.id then
                let
                    newQuantity =
                        head.quantity + change
                in
                if newQuantity <= 0 then
                    tail

                else
                    { head | quantity = newQuantity } :: tail

            else
                head :: changeQuantity tail item change
