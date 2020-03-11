module ShoppingCart exposing (ShoppingCart, ShoppingCartItem, addItem)

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
    { cart | items = setQuantityOfItem cart.items item }


setQuantityOfItem : List ShoppingCartItem -> SomeItem a -> List ShoppingCartItem
setQuantityOfItem list item =
    case list of
        [] ->
            [ { id = item.id, description = item.description, price = item.price, quantity = 1 } ]

        head :: tail ->
            if head.id == item.id then
                { head | quantity = head.quantity + 1 } :: tail

            else
                head :: setQuantityOfItem tail item
