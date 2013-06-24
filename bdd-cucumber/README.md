BDD, Cucumber
===

**BDD & Cucumber**
We've prepared the following repo, containing a "canonical" solution to HW2 against which to write your scenarios, and the necessary scaffolding for the first couple of scenarios.
The repo is *saasbook/hw3_rottenpotatoes* on GitHub.  
We suggest you first fork that repo on GitHub, then clone from your own fork:
`git clone git@github.com:YourGitHubAccount/hw3_rottenpotatoes.git`

Full instructions [here](https://docs.google.com/document/d/1dYVoAZYYFufcHKzYu-ieR4J5rbnGK38bM9J3cFEPyNA/edit#)

Autograding
===========
From within the solutions/hw3/rottenpotatoes directory, run `bundle install`, `rake db:migrate`, and `rake db:test:prepare`.
Clone the Ruby Autograder and run `rag/grade3 -a solutions/rottenpotatoes <student_solution>.tar.gz rag/hw3.yml` (note: hw3 autograder not yet merged into master of rag).
