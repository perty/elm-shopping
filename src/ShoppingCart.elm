module ShoppingCart exposing (ShoppingCart, ShoppingCartItem, addItem, removeItem)

import Money exposing (Money)


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
