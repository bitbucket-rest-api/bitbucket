describe BitBucket do
  let(:api) { BitBucket }

  describe "register_constant" do
    it "sets a constant" do
      api.register_constant({const_1: 'value1'})
    end
  end

  describe "lookup_constant" do
    it "returns the constant's value" do
      expect(api.lookup_constant('CONST_1')).to eq 'value1'
      expect{ api.lookup_constant('UNKNOWN_CONSTANT')}.to raise_error NameError
    end
  end

end
