HW 1.5 -- Introduction to GitHub and Heroku
===========================================

Part 1 -> Setup GitHub and Heroku
---------------------------------

**Procedure**

1) Sign Up for a free GitHub account at -- https://github.com/signup/free and follow the instructions given (confirming your account, adding a gravatar profile picture, etc.). You need to use the email associated with your edx account for your GitHub account as it necessary for grading purposes.

2) Sign Up for a free Heroku account at -- https://id.heroku.com/signup and again follow the instructions given on their site to create you account.

3) Set up GitHub on you VM (https://help.github.com/articles/set-up-git).

  * Add your email and name to the git config

        git config --global user.name "Your Name Here"
        git config --global user.email "user@example.com"

  * Generate SSH keys and add them to your account to authorize your VM with your GitHub account. Follow this guide on GitHub to do so - https://help.github.com/articles/generating-ssh-keys

    *WARNING* -> In Step 3, you will have problems with copying to clipboard by using the command given. So you need to manually copy it. To do so open the ssh key file with gedit/cat and then copy the contents of the file and then paste it while adding the key on github. 
    
    To open it with `gedit`,
  
          gedit ~/.ssh/id_rsa.pub
    
    Amazon AWS users, use `cat` and then copy the output from the terminal
  
          cat ~/.ssh/id_rsa.pub


4) Login to your newly created Heroku account and add the ssh keys to heroku so that your VM can deploy your apps to Heroku.

*Note*: You may either wish to create a seperate ssh key for Heroku or choose to use the ssh keys you generated in the previous step (Setting Up GitHub). In this case, we are using the ssh key we generated from the GitHub step.

    $ heroku login
    Enter your Heroku credentials
    Email: test@example.com
    Password (typing will be hidden):
    Authentication succesful!
    $ heroku keys:add
    Found existing public key: /Users/adam/.ssh/id_rsa.pub
    Uploading SSH public key /Users/adam/.ssh/id_rsa.pub... done

You have now successfully completed Part 1 of the assignment!


**Submission**

For Part 1 of this assignment, you need to submit a textfile with your GitHub username in it.

For the github username located at https://github.com/example_person/ , the format of the submitted file should be

      example_person

**Grading**

To grade the submission, you need to use the the autograders at https://github.com/saasbook/rag

    ./grade15 <github_username> <spec_file>
