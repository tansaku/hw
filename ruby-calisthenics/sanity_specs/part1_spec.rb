describe "#palindrome?" do
  it "should be defined" do
    lambda { palindrome?("Testing") }.should_not raise_error(::NoMethodError)
  end
end


describe "#count_words" do
  it "should be defined" do
    lambda { count_words("Testing") }.should_not raise_error(::NoMethodError)
  end

  it "should return a Hash" do
    count_words("Testing").class.should == Hash
  end
end
