require 'spec_helper'
require 'bitbucket_rest_api/core_ext/array'

describe Array do
  let(:array) { [:a, :b, :c, :d, { key: :value }] }

  describe '#extract_options!' do
    it 'selects a hash from the arguments list' do
      expect(array.extract_options!).to eq({ key: :value })
    end
  end
end
