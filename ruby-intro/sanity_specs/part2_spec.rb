describe "#hello" do
  it "should be defined" do
    lambda { hello("Testing") }.should_not raise_error(::NoMethodError)
  end
end
describe "#starts_with_consonant?" do
  it "should be defined" do
    lambda { starts_with_consonant?("d") }.should_not raise_error(::NoMethodError)
  end
end
describe "#binary_multiple_of_4?" do
  it "should be defined" do
    lambda { binary_multiple_of_4?("yes") }.should_not raise_error(::NoMethodError)
  end
end
