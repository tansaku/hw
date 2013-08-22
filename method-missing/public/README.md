Metaprogramming to the rescue
=============================

Extend the currency-conversion example from lecture so that you can write

    5.dollars.in(:euros)
    10.euros.in(:rupees)

etc.

You should support the currencies 'dollars', 'euros', 'rupees' , 'yen' where the
conversions are: 
* rupees to dollars, multiply by 0.019
* yen to dollars, multiply by 0.013
* euro to dollars, multiply by 1.292.

Both the singular and plural forms of each currency should be acceptable, e.g.
`1.dollar.in(:rupees)` and `10.rupees.in(:euro)` should both work.

You can use the [code shown in lecture](http://pastebin.com/agjb5qBF) as
a starting point if you wish. 
