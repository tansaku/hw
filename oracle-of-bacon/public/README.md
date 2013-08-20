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

We've provided a code skeleton and a reasonable (but not exhaustive) set
of specs for this assignment.  The assignment has 4 parts; each part has
its own specs in a `describe` group.  Initially, all specs are marked
`:pending => true` so you don't get a rash of failing tests when you
start the assignment; when you start work on any one part of the
assignment, remove the pending option from the describe block, watch the
group of tests fail, and then start writing the code to make them pass.
(This is a crude version of the Test-Driven Development methodology we
embrace later in the course; in the full version of TDD, you will write
your own tests one at a time, watching each one fail and then creating
the code to make it pass.)

# Part 0: Background (no submission needed)

A minimal RESTful query URI for OOB must include the API key (parameter
`p`), the actor from which to start search (parameter `a`), and
optionally the actor to connect to (optional parameter `b`; defaults to
Kevin Bacon if omitted).

Remember that special characters in URIs must be
escaped and that one such special character is a space, which may be
replaced by `+` in a URI.  Thus valid queries might be (if you
replace `my_key` with the valid API key above):

    http://oracleofbacon.org/cgi-bin/xml?p=my_key&a=Laurence+Olivier

which connects Laurence Olivier with Kevin Bacon, or

    http://oracleofbacon.org/cgi-bin/xml?p=my_key&a=Carrie+Fisher&b=Ian+McKellen

which connects Carrie Fisher to Ian McKellen.

* Visually inspect the XML returned for each of the above queries.  You
can view it by typing the URIs into a browser, or better, by using a
command-line tool such as `curl`.   What kinds of XML elements are
present in the response?

If there are multiple matches for an actor name, you'll get a list of
similar names so you can resubmit your query with an exact match.  For
example, try doing a query connecting Anthony Perkins to anyone.

* Visually inspect the XML returned.  How are the element types
different from those for a normal response?

Finally, if you submit a request whose URI does not include a valid API
key, you'll get a third type of response, informing you that the access
was unauthorized.

* Visually inspect the XML returned.  How does it differ from the
previous two responses?

In the rest of this assignment you'll create a Ruby wrapper library to
make it easier to use the Oracle of Bacon.  With our new library, we'd
be able to run the above three examples as follows (again replacing
`my_api_key` with the valid key given previously).  (Note that your
responses may differ slightly, as there is often more than one way to
connect two actors together and the Oracle of Bacon returns one chosen
randomly.) 

    oob = OracleOfBacon.new('my_api_key')
    oob.from = 'Laurence Olivier'
    oob.find_connections
    oob.response.type      # => :graph
    oob.response.data      # => ['Kevin Bacon', 'The Big Picture (1989)', 'Eddie Albert (I)', 'Carrie (1952)', 'Laurence Olivier']
    # try connecting Carrie Fisher to Ian McKellen
    oob.from = 'Carrie Fisher'
    oob.to = 'Ian McKellen'
    oob.find_connections
    oob.response.data      # => ['Ian McKellen', 'Doogal (2006)', 
    


# Part 1: 


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


## Troubleshooting

*  `autotest` *appears to do nothing?*  Check that you are running it in
the code's root directory (the one that has `lib` and `spec` as subdirectories)
and that the `.rspec` file exists in this root directory.

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
