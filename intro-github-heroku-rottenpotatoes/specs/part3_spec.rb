require "rspec"
require "nokogiri"
require 'rubygems'
require 'mechanize'
require 'ruby-debug'

uri = ENV['HEROKU_URI']
uri = "http://" + uri if uri and uri !~ /^http:\/\//
#uri = "http://growing-moon-5313.herokuapp.com"
uri = URI.parse(uri) if uri
host = URI::HTTP.build(:host => uri.host, :port => uri.port).to_s if uri
#$url = 'http://growing-moon-5313.herokuapp.com/movies'
$url = uri

describe "App" do
  let(:agent) {agent = Mechanize.new}
  it "should respond to simple request [0 points]" do
    page = agent.get($url)
  end
  it "should include the appropriate text [10 points]" do
    page = agent.get($url)
    expect(page.body.include?('Hello, SaaS world')).to be_true
  end
end