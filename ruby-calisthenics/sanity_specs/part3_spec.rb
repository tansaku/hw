describe "anagrams" do
  it "should be defined" do
    lambda { combine_anagrams([]) }.should_not raise_error(::NoMethodError)
  end

  it "should return an Array" do
    combine_anagrams([]).class.should == Array
  end
end
