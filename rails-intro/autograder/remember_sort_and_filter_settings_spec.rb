require 'mechanize'
require 'uri'
require 'ruby-debug'

uri = ENV['HEROKU_URI']
uri = "http://" + uri if uri !~ /^http:\/\//
uri = URI.parse(uri)
host = URI::HTTP.build(:host => uri.host, :port => uri.port).to_s

class MoviesTable
  def initialize(page)
    @page = page
  end

  def each_body_row
    @page.search("table[@id=movies]/tbody").children.filter('tr').each do |tr|
      yield MoviesTableRow.new(tr)
    end
  end
end

class MoviesTableRow
  attr_reader :columns
  def initialize(tr)
    @columns = {}
    cols = tr.children.filter('td').map{|x| x.text.strip}
    @columns[:title] = cols[0]
    @columns[:rating] = cols[1]
    @columns[:release_date] = cols[2]
    @columns[:more_info] = cols[3]
  end
end

describe "GET /movies" do
  before(:each) do
    @agent = Mechanize.new
    @movies_url = URI.join(host, 'movies')
    @page = @agent.get(@movies_url)
    @page = select_all_ratings_and_submit(@page)
  end

  context "basic tests" do
    it "should be successful" do
      @page.should_not be_nil
    end
    it 'should have a form with id ratings_form' do
      @page.should_not be_nil
      @page.form_with(:id =>'ratings_form').should_not be_nil
    end
    it "should have #ratings_submit button" do
      @page.should_not be_nil
      @page.form_with(:id => 'ratings_form').button_with(:id => 'ratings_submit').should_not == nil
    end

    it "should have checkboxes" do
      @page.should_not be_nil
      @page.form_with(:id => 'ratings_form').checkboxes.each do |checkbox|
        checkbox[:id].should =~ /ratings_\w+/
      end
    end

    it "should have #movies" do
      @page.search("#movies").should_not be_empty
    end

    it "should have #title_header" do
      @page.search("#title_header").should_not be_empty
    end

    it "should have #release_date_header" do
      @page.search("#release_date_header").should_not be_empty
    end
  end

  # Get movie rating
  def find_ratings(page=@page)
    ratings = []
    MoviesTable.new(page).each_body_row do |row|
       ratings << row.columns[:rating]
    end
    ratings.uniq
  end

  # Get form
  def get_form(page = @page)
    # FIXME: This would also be nicer with a form id
    ratings_form = nil
    page.forms.each do |form|
      if form.button_with(:id => "ratings_submit")
        ratings_form = form
      end
    end
    return page.forms.first if (ratings_form.nil? && page.forms.size == 1)
    ratings_form.should_not be_nil
    ratings_form
  end

  # Checks specified rating
  # Uncheck all other ratings
  def select_ratings(ratings_form, rating_or_ratings)
    if rating_or_ratings.is_a?(Array)
      ratings = rating_or_ratings
    else
      ratings = [rating_or_ratings]
    end

    rating_ids = ratings.map{|x| "ratings_#{x}"}
    ratings_form.checkboxes.each do |checkbox|
      if rating_ids.include? checkbox[:id]
        checkbox.check
      else
        checkbox.uncheck
      end
    end
  end

  # Selects ratings, submits, and returns new page and rating selected
  def select_ratings_and_submit(page=@page, ratings=nil)
    if ratings.nil?
      ratings = [find_ratings.first]
    end

    ratings_form = get_form page

    select_ratings(ratings_form, ratings)

    # Submit form
    ratings_submit = ratings_form.button_with(:id => "ratings_submit")
    if ratings_submit
      response = ratings_form.submit(ratings_submit)
    else
      response = ratings_form.submit
    end
    [response, ratings]
  end

  def verify_ratings_filter(page, ratings)
    # In response, check all of the rows for rating
    count = 0
    table = MoviesTable.new(page)
    table.each_body_row do |row|
      ratings.should include row.columns[:rating]
      count += 1
    end
    count.should be >= 1
  end

  def verify_sort_order(page, field)
    table = MoviesTable.new(page)
    column = []
    table.each_body_row {|x| column << x.columns[field]}
    column = column.select{|x| x != ""}. # gets rid of that Amelie blank release date field
      map{|x| x.downcase.gsub(/[^a-z0-9]/, ' ').strip}
    column.should_not be_empty
    column.should == column.sort
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

    table = page.search("#movies")
    header_row = table.search("thead/tr")[0]
    if field.to_s == 'title'
      idx = 0
    else
      idx = 2
    end
    href = header_row.search("th")[idx].search("a")[0]['href']
    link = page.link_with(:href => href)
    return link if link

    raise "Cannot find sort link"
  end

  def check_redirect(page)
    unless (page.respond_to?(:code) && page.code =~ /3\d\d/) or (page.link_with(:text => "redirected"))
      raise "did not redirect"
    end
  end

  context "when selecting a movie rating" do
    it "should remember the rating selected [20 points]" do
      response, ratings = select_ratings_and_submit
      response = @agent.get(@movies_url) # blank parameters
      verify_ratings_filter(response, ratings)
    end

    it "should allow new ratings to be selected [15 points]" do
      ratings = find_ratings(@page)
      ratings.length.should be >= 2
      ratings.should have_at_least(2).items
      first_rating = ratings[0]
      second_rating = ratings[1]
      response, _ = select_ratings_and_submit(@page, first_rating)
      response, _ = select_ratings_and_submit(response, second_rating)
      verify_ratings_filter(response, second_rating)
    end

    it "should redirect to a RESTful route [15 points]" do
      response, ratings = select_ratings_and_submit
      @agent.redirect_ok = false
      response = @agent.get(@movies_url)
      check_redirect(response)
    end
  end

  context "when selecting a sort field" do
    it "should remember the sort order [20 points]" do
      sorted_page = get_sort_link(@page, 'title').click
      response = @agent.get(@movies_url) # blank parameters
      verify_sort_order(response, :title)
    end

    it "should allow a new sort order to be selected [15 points]" do
      sorted_page = get_sort_link(@page, 'title').click
      response = get_sort_link(@page, 'release_date').click
      verify_sort_order(response, :release_date)
    end

    it "should redirect to a RESTful route [15 points]" do
      response = get_sort_link(@page, 'title').click
      @agent.redirect_ok = false
      response = @agent.get(@movies_url)
      check_redirect(response)
    end
  end
end
