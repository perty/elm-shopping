module Catalog exposing (CatalogItem, catalogItems)

import Money exposing (Money, eur)


type alias CatalogItem =
    { id : Int
    , description : String
    , price : Money
    }


catalogItems : List CatalogItem
catalogItems =
    [ CatalogItem 1 "Super fluid" (eur 2599)
    , CatalogItem 2 "Twat, super" (eur 355)
    ]
