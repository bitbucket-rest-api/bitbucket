require 'spec_helper'
require 'bitbucket_rest_api/core_ext/array'

describe Array do
  let(:array) { [:a, :b, :c, :d, { key: :value }] }
  describe '#except' do
    it 'removes the keys' do
      new_array = array.except(:a, :b)

      expect(new_array).to_not include(:a)
      expect(new_array).to_not include(:b)
    end
  end

  describe '#except!' do
    xit 'removes the keys from the self' do
      array = [:a, :b, :c, :d]
      array.except!(:a, :b)

      expect(array).to_not include(:a)
      expect(array).to_not include(:b)
    end
  end

  describe '#extract_options!' do
    it 'selects a hash from the arguments list' do
      expect(array.extract_options!).to eq({ key: :value })
    end
  end
end
