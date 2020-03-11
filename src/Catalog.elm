module Catalog exposing (CatalogItem, catalogItems)

import Money exposing (Money, eur)


type alias CatalogItem =
    { id : Int
    , description : String
    , price : Money
    }


catalogItems : List CatalogItem
catalogItems =
    [ CatalogItem 1 "Backstage passes" (eur 2599)
    , CatalogItem 2 "Aged Brie" (eur 355)
    , CatalogItem 3 "Sulfuras" (eur 404)
    , CatalogItem 4 "Conjured" (eur 1337)
    ]
