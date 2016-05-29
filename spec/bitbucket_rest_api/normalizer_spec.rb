# encoding: utf-8

require 'spec_helper'
require 'bitbucket_rest_api/core_ext/hash'

describe BitBucket::Normalizer, '#normalize!' do
  let(:hash) { { 'a' => { :b => { 'c' => 1 }, 'd' => ['a', { :e => 2 }] } } }

  let(:klass) do
    Class.new do
      include BitBucket::Normalizer
    end
  end

  subject(:instance) { klass.new }

  context '#normalize!' do
    it 'converts hash keys to string' do
      ['a', 'b', 'c'].each do |key|
        expect(subject.normalize!(hash).has_deep_key?(key)).to eq(true)
      end
    end

    it 'should stringify all the keys inside nested hash' do
      actual = subject.normalize! hash
      expected = { 'a' => { 'b'=> { 'c' => 1 }, 'd' => ['a', { 'e'=> 2 }] } }
      expect(actual).to eq expected
    end
  end
end # BitBucket::Normalizer
