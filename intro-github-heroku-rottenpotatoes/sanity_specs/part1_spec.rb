describe "Stack" do
  it "should define a constructor" do
    lambda { Stack.new }.should_not raise_error(::NoMethodError)
  end
  %w(pop push clear).each do |method|
    it "should define #{method}" do
      Stack.new().should respond_to method
    end
  end
  # would be nice if we could suppress the stack trace from the framework
  # for this to be a github homework we would need to test that someone has gone through the
  # sequence of steps necessary to get something on github
  #  I guess we ask for their git username and then check they have created the necessary repo?

  # part 1 could be just the stack, get it all working
  # part 2 github --> commit stack code (+sinatra) to github --> must check that correct code is on github
  # ... have them clone an existing sinatra app, make one small change (locally, and then committing to github),
  # and then have them deploy it
  # part 3 could be a heroku deploy?  as part of a sinatra app?


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


end