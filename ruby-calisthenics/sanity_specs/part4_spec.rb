describe "dessert" do
  it "should define a constructor" { lambda { Dessert.new }.should_not raise_error(::NoMethodError) }
  %w(healthy? delicious? lowfat?).each do |method|
    it "should define #{method}" { Dessert.new('a',1).should respond_to method }
  end
end

describe "jellybean" do
  it "should define a constructor" { lambda { JellyBean.new }.should_not raise_error(::NoMethodError) }
  %w(healthy? delicious? lowfat?).each do |method|
    it "should define #{method}" { JellyBean.new('a',1).should respond_to method }
  end
end
