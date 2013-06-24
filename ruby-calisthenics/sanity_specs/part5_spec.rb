describe "Class" do
  it "should have an attr_accessor_with_history method" do
    lambda { Class.new.attr_accessor_with_history }.should_not raise_error(::NoMethodError)
  end
end
