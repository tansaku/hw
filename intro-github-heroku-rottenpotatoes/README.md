HW 1.5 -- Introduction to GitHub and Heroku
===========================================

Part 1 -> Create GitHub account and Fork simple Sinatra repository
---------------------------------

**Procedure**

1) Sign Up for a free GitHub account at -- https://github.com/signup/free and follow the instructions given (confirming your account, adding a gravatar profile picture, etc.). You should use the email associated with your edx account for your GitHub account as it necessary for grading purposes.

2) Fork the following repository https://github.com/heroku/ruby-sample

You have now successfully completed Part 1 of the assignment!


Part 2 -> Setup Git on VM, Modify local file and Push to Github
---------------------------------

**Procedure**

1) Set up git on your VM (https://help.github.com/articles/set-up-git).

  * Add your email and name to the git config

        git config --global user.name "Your Name Here"
        git config --global user.email "user@example.com"

  * Generate SSH keys and add them to your account to authorize your VM with your GitHub account. Follow this guide on GitHub to do so - https://help.github.com/articles/generating-ssh-keys

    *WARNING* -> In Step 3, you will have problems with copying to clipboard by using the command given. So you need to manually copy it. To do so open the ssh key file with gedit/cat and then copy the contents of the file and then paste it while adding the key on github.

    To open it with `gedit`,

          gedit ~/.ssh/id_rsa.pub

    Amazon AWS users, use `cat` and then copy the output from the terminal

          cat ~/.ssh/id_rsa.pub

2) Clone your forked repository

3) Modify the file web.rb on your local system so that it says "Hello, SaaS world"
[NOTE: would like to make this EdX username received from autograder, to confirm student has not
just pointed system at someone else's repo]

4) Commit these changes to your local repository

5) Push these changes to Github

You have now successfully completed Part 2 of the assignment!

Part 3 -> Deploy to Heroku
---------------------------------

**Procedure**

1) Sign Up for a free Heroku account at -- https://id.heroku.com/signup and again follow the instructions given on their site to create you account.

2) Login to your newly created Heroku account and add the ssh keys to heroku so that your VM can deploy your apps to Heroku.

*Note*: You may either wish to create a seperate ssh key for Heroku or choose to use the ssh keys you generated in the previous step (Setting Up GitHub). In this case, we are using the ssh key we generated from the GitHub step.

    $ heroku login
    Enter your Heroku credentials
    Email: test@example.com
    Password (typing will be hidden):
    Authentication succesful!
    $ heroku keys:add
    Found existing public key: /Users/adam/.ssh/id_rsa.pub
    Uploading SSH public key /Users/adam/.ssh/id_rsa.pub... done


3) Deploy your app to heroku

4) Adjust the name of your app to something memorable

You have now successfully completed Part 3 of the assignment!

**Submission**

For Part 1 and 2 of this assignment, you need to submit a textfile with your GitHub username in it.

For the github username located at https://github.com/example_person/ , the format of the submitted file should be

      example_person

For Part 3 of this assignment, you need to submit a textfile with the URL to the heroku repository (could we use octokit again? might need to be mechanize)

**Grading**

To grade the submission, you need to use the the autograders at https://github.com/saasbook/rag

    ./new_grader <github_username> <spec_file>


==========
  Early thoughts on sequence.  Should we have them deploy to heroku first?

  # sequence that the student does:   have to include https://help.github.com/articles/generating-ssh-keys

  # 1. fork https://github.com/heroku/ruby-sample.git    # on github
  # 2. clone locally                                     # e.g. git clone https://github.com/tansaku/ruby-sample.git
  # 3. deploy to heroku                                  # e.g. wget -qO- https://toolbelt.heroku.com/install.sh | sh, heroku login, heroku create
  # 4. make minor change, commit to github               # git commit, git push
  # 5. re-deploy to heroku                               # git push heroku master

  # for raw file: Octokit.contents 'tansaku/ruby-sample', :path => 'web.rb', :accept => 'application/vnd.github.raw'

  #720  git clone https://github.com/tansaku/ruby-sample.git
  #721  cd ruby-sample/
  #722  ls
  #723  rubymine
  #724  more web.rb
  #725  mine .
  #726  heroku login
  #727  wget -qO- https://toolbelt.heroku.com/install.sh | sh
  #728  which brew
  #729  brew install wget
  #730  wget -qO- https://toolbelt.heroku.com/install.sh | sh
  #731  heroku install
  #732  echo 'PATH="/usr/local/heroku/bin:$PATH"' >> ~/.profile
  #733  which heroku
  #734  /usr/local/heroku/bin/heroku
  #735  /usr/local/heroku/bin/heroku login
  #736  echo $PATH
  #737  source ~/.profile
  #738  heroku create
  #739  open http://stormy-garden-2703.herokuapp.com/
  #740  more web.rb
  #741  git push heroku master
  #742  cd ~/.ssh
  #743  ssh-keygen -t rsa -C "tansaku@gmail.com"
  #744  pbcopy < ~/.ssh/id_rsa.pub
  #745  git push heroku master
  #746  cd ../Documents/
  #747  cd Github/
  #748  cd ruby-sample/
  #749  ssh -T git@github.com
  #750  git push heroku master
  #751  heroku keys:add
  #752  git push heroku master
  #753  heroku keys:add
  #754  git push heroku master


