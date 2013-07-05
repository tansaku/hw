describe "Github" do
  it "should contain a repository for the user" do
    github = Github.new
    github.repos.commits.all  Repo.user, Repo.name

    file_contents = Octokit.contents 'tansaku/ruby-sample', :path => 'web.rb', :accept => 'application/vnd.github.raw'
    expect(file_contents).to match /Hello, SaaS world/
  end
end