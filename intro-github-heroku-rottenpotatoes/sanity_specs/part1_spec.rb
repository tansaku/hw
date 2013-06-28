describe "Stack" do
  it "should define a constructor" { lambda { Stack.new }.should_not raise_error(::NoMethodError) }
  %w(pop? push? clear?).each do |method|
    it "should define #{method}" { Stack.new('a',1).should respond_to method }
  end
end