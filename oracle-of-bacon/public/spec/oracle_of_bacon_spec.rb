load '../solutions/lib/oracle_of_bacon.rb'

describe OracleOfBacon do
  describe 'validations' do
    before(:each) { @orb = OracleOfBacon.new('fake_api_key') }
    describe 'when new' do
      subject { @orb }
      it { should_not be_valid }
    end
    describe 'when only From is specified' do
      subject { @orb.from = 'Carrie Fisher' ; @orb }
      it { should be_valid }
      its(:from) { should == 'Carrie Fisher' }
      its(:to)   { should == 'Kevin Bacon' }
    end
    describe 'when only To is specified' do
      subject { @orb.to = 'Ian McKellen' ; @orb }
      it { should be_valid }
      its(:from) { should == 'Kevin Bacon' }
      its(:to)   { should == 'Ian McKellen'}
    end
    describe 'when From and To are both specified' do
      context 'and distinct' do
        subject { @orb.to = 'Ian McKellen' ; @orb.from = 'Carrie Fisher' ; @orb }
        it { should be_valid }
        its(:from) { should == 'Carrie Fisher' }
        its(:to)   { should == 'Ian McKellen'  }
      end
      context 'and the same' do
        subject {  @orb.to = @orb.from = 'Ian McKellen' ; @orb }
        it { should_not be_valid }
      end
    end
  end
  describe '#make_uri_from_arguments' do
    it 'should escape spaces'
    # result shoud match URI::regexp
    it 'should escape illegal characters'
  end
  describe 'failed connection' do
    it 'due to invalid object should raise InvalidError' do
      oob = OracleOfBacon.new
      oob.should_not be_valid   # just checking
      lambda { oob.find_connections }.should raise_error(OracleOfBacon::InvalidError)
    end
    it 'due to network error should raise NetworkError' do
    end
  end
  describe 'parsing XML graph of 3 edges and 2 vertices' do
    pending
    before(:each) do
      @oob = OracleOfBacon.new
      @xml = IO.read(File.open 'graph_example.xml')
    end
  end
    
end
      
