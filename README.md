# elm-shoppping
A little example in Elm. Inspired by the ["Grokking Simplicity"](https://www.manning.com/books/grokking-simplicity) book. 

So the Javascript in the book had some horrible things like "find in DOM" and imperatives such as "update icons".

In Elm, the view is simply a calculation (pure function) of the data (application state). So no need to find things in the DOM
to manipulate. With modules, it is possible to put calculations related to a shopping cart in a separate module.

Note how the current design has items that are in the product catalog `CatalogItem`and items in the cart `ShoppingCartItem`. 
They are similar but different. The `addItem` function accepts anything with an id, description and a price. 

The representation of money is designed for run-time handling of different currencies. 
This is a bit unlike I would do it and I started out with a design with phantom types to represent money. But then
the shopping cart would need to know its currency at compile-time. Deciding the currency in run-time is flexible 
but does not gurantee as much as compile-time. What if we add items with prices in different currencies?
