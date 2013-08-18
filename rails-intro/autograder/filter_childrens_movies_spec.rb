require 'mechanize'
require 'uri'
require 'ruby-debug'

uri = ENV['HEROKU_URI']
uri = "http://" + uri if uri !~ /^http:\/\//
#uri = "http://growing-moon-5313.herokuapp.com" passes all tests
uri = URI.parse(uri) if uri
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
    @base_uri = URI.join(host, 'movies')
    @page = @agent.get(@base_uri)
   # @page = select_all_ratings_and_submit(@page)
  end

  it "should be successful" do
  end

  it "should have #ratings_form form [5 points]" do
    @page.should_not be_nil
    @page.form_with(:id =>'ratings_form').should_not be_nil
  end
  
  it "should have #ratings_submit button [5 points]" do
    # FIXME: In future offerings, tell students to specify an id for the form itself.

    @page.form_with(:id => 'ratings_form').button_with(:id => 'ratings_submit').should_not == nil
  end

  it "should have checkboxes [5 points]" do
    # FIXME
    # Use the following test case in the future
    @page.form_with(:id => 'ratings_form').checkboxes.each do |checkbox|
      checkbox[:id].should =~ /ratings_\w+/
    end
  end
  # Get movie rating
  def find_rating(page = @page)
    rating = page.search("table[@id=movies]/tbody/tr[1]/td[2]").text
    rating.should_not be_empty
    rating
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

  # Selects a rating, submits, and returns new page and rating selected
  def select_rating_and_submit(page=@page)
    rating = find_rating page
    ratings_form = get_form page

    # Check corresponding rating
    # Uncheck all other ratings
    ratings_form.checkboxes.each do |checkbox|
      if checkbox[:id] == "ratings_#{rating}"
        checkbox.check
      else
        checkbox.uncheck
      end
    end

    # Submit form
    ratings_submit = ratings_form.button_with(:id => "ratings_submit")
    response = ratings_form.submit(ratings_submit)
    [response, rating]
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
    column = column.select{|x| x != ""}. # gets rid of that Amelie blank release date field
      map{|x| x.downcase.gsub(/[^a-z0-9]/, ' ').strip}
    column.should_not be_empty
    column.should == column.sort
  end
 
  context "When I first visit the page" do
    it "should have all checkboxes checked  [8 points]" do
     checked_boxes=@page.form_with(:id => 'ratings_form').checkboxes_with(:checked=>true)
     
     checkboxes= @page.form_with(:id => 'ratings_form').checkboxes.each do |checkbox|
       checkbox[:id].should =~ /ratings_\w+/
       checked_boxes.include?(checkbox).should be_true, "unchecked checkbox found with id #{checkbox[:id]}"
     end
    end
    it "should have movies visible [7 points]" do
      initial_rows=0
      total_rows=0
      MoviesTable.new(@page).each_body_row do |row|
        initial_rows+=1
      end
      
      @page=select_all_ratings_and_submit(@page)
      MoviesTable.new(@page).each_body_row do |row|
        total_rows+=1
      end
      
      initial_rows.should == total_rows
    end 
  
  
  end
 
  context "when selecting a movie rating" do
    before(:each) do 
      @page = select_all_ratings_and_submit(@page)
    end
    it "should only display movies of that rating [20 points]" do
      response, rating = select_rating_and_submit

      # In response, check all of the rows for rating
      count = 0
      table = MoviesTable.new(response)
      table.each_body_row do |row|
        row.columns[:rating].should == rating
        count += 1
      end
      count.should be >= 1
    end

    it "should automatically check the selected rating in the response [25 points]" do
      response, rating = select_rating_and_submit
      new_ratings_form = get_form(response)

      #p response
      new_ratings_form.checkboxes.should_not be_empty
      new_ratings_form.checkboxes.each do |checkbox|
        if checkbox[:id] == "ratings_#{rating}"
          checkbox.should be_checked
        else
          checkbox.should_not be_checked
        end
      end
    end

    # FIXME
    # Removed because it wasn't in the original spec
    # Should add back into future versions of course
    #it "should preserve the sort order" do
    #  sorted_page = @page.link_with(:id => 'title_header').click
    #  @agent.cookie_jar.clear! # ignore session
    #  response, rating = select_rating_and_submit(sorted_page)

    #  table = MoviesTable.new(response)
    #  previous_title = ''
    #  table.each_body_row do |row|
    #    row.columns[:title].should be >= previous_title
    #    previous_title = row.columns[:title]
    #  end
    #end
  end

  context "when selecting a sort column" do
     before(:each) do 
      @page = select_all_ratings_and_submit(@page)
    end
    it "should preserve the ratings filter [25 points]" do
      filtered_page, rating = select_rating_and_submit
      sorted_page = get_sort_link(filtered_page, 'title').click
      table = MoviesTable.new(sorted_page)
      columns = []
      table.each_body_row do |row|
        columns << row.columns[:title]
        row.columns[:rating].should eq(rating)
      end
      sorted?(columns).should be_true
    end
  end
end
