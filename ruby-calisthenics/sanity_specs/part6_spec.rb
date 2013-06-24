describe "palindrome" do
  it "should be defined for string" do
    lambda { ''.palindrome? }.should_not raise_error(::NoMethodError)
  end
  it "should be defined for enumerable" do
    lambda { [].palindrome? }.should_not raise_error(::NoMethodError)
  end
end
