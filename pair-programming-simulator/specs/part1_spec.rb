describe "Stack" do
  it "should define a constructor" do
    lambda { Stack.new }.should_not raise_error(::NoMethodError)
  end
  %w(pop push clear).each do |method|
     it "should define #{method}" do
      Stack.new().should respond_to method
    end
  end
end