describe "BookInStock" do
  it "should be defined" do
    lambda { BookInStock.new }.should_not raise_error(::NameError)
  end
end
describe "#price_in_cents" do
  it "should be defined" do
    lambda { price_in_cents(30.50) }.should_not raise_error(::NoMethodError)
  end

end

