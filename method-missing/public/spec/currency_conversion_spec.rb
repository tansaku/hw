require 'currency_conversion'
require 'debugger'

describe 'Currency conversion', :pending => true do
  it 'converts rupee (singular) to dollars' do
    2.rupee.in(:dollar).should be_between(0.037, 0.039)
  end
  it 'converts rupees (plural) to dollars' do
    2.rupees.in(:dollars).should be_between(0.037, 0.039)
  end
  it 'converts yen to dollars' do
    1146.yen.in(:dollars).should be_between(14.85, 14.95)
  end
end

