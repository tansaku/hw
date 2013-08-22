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
$url = URI.join(host, 'movies').to_s


# Logic to parse column HEADER from a html TABLE.
# from http://stackoverflow.com/questions/8749101/parse-html-table-using-nokogiri-and-mechanize
class TableExtractor  
  def self.extract_column table, header
    table.search('tbody/tr').collect do |row|
      case header
      when :title
        row.at("td[1]").text.strip
      when :rating
        row.at("td[2]").text.strip
      when :release_date
        row.at("td[3]").text.strip
      when :more_info
        row.at("td[4]").text.strip
      end
    end
  end
end

describe "App" do
  it "should respond to simple request [0 points]" do
    agent = Mechanize.new
    page = agent.get($url)
  end
end

def select_all_ratings_and_submit(page)
  # This block of code is to account for students who left the ratings unchecked by default, and therefore not displaying anything
  page.forms.each do |form|
    form.checkboxes.each do |cb|
      cb.check
    end
    submit = form.button_with(:id => 'ratings_submit')
    if submit
      page = form.submit(submit)
    else
      page = form.submit
    end
  end
  page
end

def get_sort_link(page, field)
  id = "#{field}_header"
  link = page.link_with(:id => id)
  return link if link

  if not page.search("##{id}").empty?
    href = page.search("##{id}")[0].search('a')[0]['href']
    link = page.link_with(:href => href)
    return link if link
  end

  raise "Cannot find sort link"
end

def sorted?(column)
  column = column.select{|x| x != ""}.# gets rid of that Amelie blank release date field
    map{|x| x.downcase.gsub(/[^a-z0-9]/, ' ').strip}
  column.should_not be_empty
  column.should == column.sort
end


describe "Table header" do
  before(:each) do
    @startpage = Mechanize.new.get($url)
    @startpage = select_all_ratings_and_submit(@startpage)
  end
  it "should have link to sort by title [10 points]" do
    page = @startpage.link_with(:id => 'title_header')
    page.should_not be_nil
  end
  it "should have link to sort by release date [10 points]" do
    page = @startpage.link_with(:id => 'release_date_header')
    page.should_not be_nil
  end
end

describe "Table" do
  before(:each) do
    @startpage = Mechanize.new.get($url)
    @startpage = select_all_ratings_and_submit(@startpage)
  end
  it "should be sortable by title [20 points]" do
    sorted_page = get_sort_link(@startpage, 'title').click
    table = sorted_page.parser.css("#movies").first
    column = TableExtractor.extract_column table, :title
    sorted?(column).should be_true

  end
  it "should be sortable by release date [20 points]" do
    sorted_page = get_sort_link(@startpage, 'release_date').click
    table = sorted_page.parser.css("#movies").first
    column = TableExtractor.extract_column table, :release_date
    sorted?(column).should be_true
  end
  # This is not actually part of the spec
  #it "should highlight neither header by default" do
  #  title = @startpage.parser.css('#title_header')
  #  release_date = @startpage.parser.css('#release_date_header')
  #  # TODO check css styling
  #end
  it "should highlight title header when sorted [20 points]" do
    sorted_page = get_sort_link(@startpage, 'title').click
    title = sorted_page.parser.css('#title_header')
    release_date = sorted_page.parser.css('#release_date_header')
    # TODO check css styling
    sorted_page.search('table[@id=movies]/thead/tr/th[1]')[0].attributes['class'].value.should =~ /\bhilite\b/
  end
  it "should highlight release date header when sorted [20 points]" do
    sorted_page = get_sort_link(@startpage, 'release_date').click
    title = sorted_page.parser.css('#title_header')
    release_date = sorted_page.parser.css('#release_date_header')
    # TODO check css styling
    sorted_page.search('table[@id=movies]/thead/tr/th[3]')[0].attributes['class'].value.should =~ /\bhilite\b/
  end
end
