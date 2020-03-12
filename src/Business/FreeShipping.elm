module Business.FreeShipping exposing (freeShipping)

-- Offer free shipping. We offer free shipping if the total amount in the cart is at least ¢20.

import Money exposing (Money)


freeShipping : Money -> Bool
freeShipping money =
    money.currencyCode == Money.Eur && money.amount >= 2000
