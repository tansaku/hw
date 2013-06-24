describe "CartesianProduct" do
  it "should exist" do
    lambda { CartesianProduct.new() }.should_not raise_error(::NoMethodError)
  end
end
