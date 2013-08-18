Autogradable homeworks for Engineering Software as a Service (ESaaS)
====================================================================

This repo contains auto-gradable homeworks for ESaaS, designed to work
with OpenEdX.

Each homework has the following structure:

`public/` - the parts that can be made visible to students; you should
publish this whole directory.  Typically includes:
* `public/README.md` (or similar) - the handout describing the work
* `public/spec/` "Sanity check" spec files for the students (be sure to
include a `.rspec` file so that `autotest` works out-of-the-box)
* `public/lib/`  Skeleton files to get the students started

`solutions/` - private directory for instructors, containing:
* `README.md` - optional, any explanations about the solutions
* `solutions/lib` - the solutions of record
* Whatever other files are appropriate for grading.  For example, if
using the RSpec-based autograder, `solutions/spec` might contain the
spec files.

`config.yml` - configuration info for the OpenEdX autograders
