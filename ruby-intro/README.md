Ruby Intro
===

Skeleton code and sanity specs for homework 0

Instructions
===========

1. Basic Ruby Practice
note: looking up the documentation on Array and Hash will help tremendously with these exercises
and Enumerable, no? -- RI

Define a method sum which takes an array of integers as an argument and returns the sum of its elements.

Define a method max_2_sum which takes an array of integers as an argument and returns the sum of its two largest elements.

Define a method sum_to_n? which takes an array of integers and an additional integer, n, as arguments and returns true if exactly two elements in the array of integers sum to n.

2. Strings and Regular Expressions

Define a method hello(name) which takes in a string representing a name and prints out “Hello, “ followed by the name.

Define a method starts_with_consonant?(s) which takes in a string and returns true if it starts with a consonant and false otherwise.

Define a method binary_multiple_of_4?(s) which takes in a string and returns true if it represents a binary number which is a multiple of 4.

3. Object Oriented Example

Define a class BookInStock which represents a book with an isbn number, isbn,and price of the book, price, as attributes. Also include the proper getters and setters for these attributes. Include a method, price_in_cents, that displays the price of the book in cents. Don’t forget the initialize method
When you’re done, test the code with something like this:

book = BookInStock.new("isbn1", 33.80)
puts "ISBN = #{book.isbn}"
puts "Price = #{book.price}"
book.price = book.price * 0.75
puts "New price = #{book.price}"



Skeleton Code
=============

The skeleton code for parts 1-3 are located in `skeletons/`.

Running Sanity Specs
====================

To run the sanity specs, please make sure `rspec` is installed.
To install rspec, run `gem install rspec`.
If you have your solution saved to a file located at `path/to/solution.rb`, and
the corresponding spec is located at `other_path/to/sanity_spec.rb`, then you can run
the sanity spec with:

    rspec path/to/solution.rb other_path/to/sanity_spec.rb

The output should look something like:

    ...

    Finished in 0.00206 seconds
    3 examples, 0 failures

Autograding
===========
Clone the Ruby Autograder and run `rag/grade <student's solution> <spec file>`.
