Method-Missing metaprogramming
==============================

This homework builds on the example in class where we extended the
`Numeric` class using `method_missing` to do this trick:

    5.rupees  # => returns an amount in dollars

The homework asks the student to extend it to convert between arbitrary
currencies:
 
    5.rupees.in(:euros)

This requires defining a new instance method `in` and mixing it into
`Numeric`. 
