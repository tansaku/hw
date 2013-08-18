describe "Currency conversion" do

  # 2 points for each of the singular forms
  it "correctly converts currency from rupees to dollars (singular) [2 points]" do
    2.rupee.in(:dollar).should be_between(0.037, 0.039)
  end
  it "correctly converts currency from yen to dollars (singular) [2 points]" do
    3.yen.in(:dollar).should be_between(0.038, 0.040)
  end
  it "correctly converts currency from euro to dollars (singular) [2 points]" do
    6.euro.in(:dollar).should be_between(7.75, 7.76)
  end

  # 5 pts for each of the plural forms
  it "correctly converts currency from rupees to dollars (plural) [3 points]" do
    2.rupees.in(:dollars).should be_between(0.037, 0.039)
  end
  it "correctly converts currency from yen to dollars (plural) [3 points]" do
    3.yen.in(:dollars).should be_between(0.038, 0.040)
  end
  it "correctly converts currency from euro to dollars (plural) [3 points]" do
    6.euros.in(:dollars).should be_between(7.75, 7.76)
  end

  # 19 points for integration testing
  it "correctly converts currency from rupees to yen, euros to rupees, yen to euros [15 points]" do
    5.rupees.in(:yen).should be_between(7.2, 7.4)
    0.39.euros.in(:rupees).should be_between(26.5, 26.6)
    1146.yen.in(:dollars).should be_between(14.85, 14.95)
  end
end
