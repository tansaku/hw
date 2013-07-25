require 'octokit'

describe "Github" do
  it "should contain a repository for the user" do

    file_contents = Octokit.contents Repo.user+'/ruby-sample', :path => 'web.rb',
                                            :accept => 'application/vnd.github.raw'
    expect(file_contents).to match /Hello, SaaS world/
    # would like this grading to involve EdX username pulled in from grader
    # would also like to be checking that the commit took place (could ask for specific commit message)
  end
end