describe "#sum" do
  it "should be defined" do
    lambda { sum([1,3,4]) }.should_not raise_error(::NoMethodError)
  end
end

describe "#max_2_sum" do
  it "should be defined" do
    lambda { max_2_sum([1,2,3]) }.should_not raise_error(::NoMethodError)
  end
end

describe "#sum_to_n" do
  it "should be defined" do
    lambda { sum_to_n?([1,2,3]) }.should_not raise_error(::NoMethodError)
  end
end
