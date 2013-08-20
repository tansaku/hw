The Oracle of Bacon
===================

This assignment will give you some exposure in using Ruby code in a
service-oriented architecture.  It will:

1. Give you more exposure to RSpec

2. Introduce you to the use of an XML-based RESTful API, the XPath
syntax for parsing XML documents, and the use of an XML parsing library
in Ruby (Nokogiri)

3. Give you some more practice in Ruby programming, especially in
discovering and using libraries useful in SOA environments.

# Background: Oracle of Bacon

The [Oracle of Bacon](http://oracleofbacon.org) is a fanciful website
maintained by Berkeley alumnus Patrick Reynolds.  You enter the names of
two actors (if you leave either one blank, it defaults to Kevin Bacon)
and it computes the number of links or degrees of separation ("Bacon
number") between the two actors, using information from the Internet
Movie Database (IMDb).  A "link" is a movie that two actors have worked
on together.  For example, Sir Laurence Olivier has a Bacon number of 2:

   Laurence Olivier \_ Dracula (1979)
                    /
    Frank Langella  \_ Frost/Nixon (2008)
                    /         
        Kevin Bacon    

You can read this as: "Laurence Olivier starred in Dracula with
Frank Langella; Frank Langella starred in Frost/Nixon with Kevin
Bacon."

The website also has a RESTful XML
API that returns raw XML
documents rather than complete Web pages.  We will use this API in this
assignment.  You can experiment with the API at [this test
page](http://oracleofbacon.org/xmltest.html), but you will need to
provide an API key.  The key provided for using the API in this course
is in the picture below, to avoid having it indexed by search engines:

![Image of API key](./api_key.png)




- Marshal arguments into a URI query string using CGI.escape(str) and
joining them together with '&'  (Rails has this as a utility...)
   gotchas: must escape both keys and values

- access OOB:
  require 'open-uri'
  Nokogiri::XML(open(uri))

  experiment with XML doc with Nokogiri::XML::Node#xpath
  Why is the XML document also an XML node?

- Should return a Result object.  
  result.type == graph (which may be empty)
   result.to_s # => "X has a Y number of N"
   result.graph # => [[actor1, movie1], [actor2, movie1], ...] in any order
   result.ascii_graph # => ASCII art represntation of graph
   result.picture_graph(filename):  we'll provide func that takes
       result.graph and generates an openable PNG file (runs "dot -Tpng
       -ofile.png graph.txt") 


  result.type == multiple_match:  
   result.matches = ['actor 1', 'actor 2', 'actor 3']

Hints for this step: 

* `zip` interleaves the element of its receiver with those of its
argument, using `nil` to pad if the first array is longer than the
second; that is, `[:a,:b,:c].zip([1,2])==[[:a,1],[:b,2],[:c,nil]]`

* `flatten` takes an array that includes arbitrarily nested arrays and
flattens them into a single array with no nested arrays, that is,
`[[:a,1],[:b,2],[:c,nil]].flatten==[:a,1,:b,2,:c,nil]` 

* `compact` removes nil elements from a collection, that is,
`[:a,1,:c,nil].compact==[:a,1,:c]`

* The `text` method on a `Nokogiri::XML::Node` returns the actual text
content of that node.  That is, if `node == <actor>Carrie
Fisher</actor>`, then `node.text == "Carrie Fisher"`.


- Create OracleOfBacon instance method:
  @oracle.connect(:from => '', :to => '')
  if either From or To omitted, assumes Bacon
  Both cannot be omitted; exception
  If unauthorized => exception

  Multiple matches: you'll get a <spellcheck> document. eg Anthony Perkins.

- Call and verify XML response

- If can't find, should return empty

- Print string descrition: "X has a Y number of N" (N= #movies)

- Print graph:

   Actor 1 \_ Movie 1
           /
   Actor 2 \_ Movie 2
           /         
   Actor 3 

Nokogiri docs: http://nokogiri.org/
Docs for Net::HTTP, URI:  http://ruby-doc.org/stdlib-1.9.3
