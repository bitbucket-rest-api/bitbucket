require 'spec_helper'

describe BitBucket::Response::Mashify do
  # let(:mashify) { described_class.new }
  describe 'parse' do
    before do
      @mashify = BitBucket::Response::Mashify.new
      @string = "Fantastic week!"
      @array = ['Monday', 'Tuesday']
      @hash = {one: 'one', two: 'two', three: 'three'}
      @array_with_hash = ['banana', 'apple', {:third => 'mango'}]
    end
    it 'parses a hash an returns a hashie mash' do
      hashie_mash = @mashify.parse(@hash)
      expect(hashie_mash.one).to eq("one")
    end

    it 'parses a hash that is within an array' do
      array_hashie_mash = @mashify.parse(@array_with_hash)
      expect(array_hashie_mash[2].third).to eq("mango")
    end

    it 'returns same object if the object does not contain a hash' do
      string = @mashify.parse(@string)
      array = @mashify.parse(@array)

      expect(string).to eq(@string)
      expect(array.length).to eq(2)
      expect(array[0]).to eq("Monday")
    end
  end
end
