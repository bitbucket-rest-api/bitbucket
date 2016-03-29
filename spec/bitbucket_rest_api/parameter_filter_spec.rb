require 'spec_helper'
require 'bitbucket_rest_api/core_ext/hash'

describe BitBucket::ParameterFilter, '#filter!' do
  let(:hash) {  { :a => { :b => { :c => 1 } } }  }
  let(:array) { [{ :a => { :b => { :c => 1 } } }, {d: {e: 2}}] }

  let(:klass) {
    Class.new do
      include BitBucket::ParameterFilter
    end
  }

  subject(:instance) { klass.new }

  it 'removes unwanted keys from hash' do
    instance.filter!([:a], hash)
    expect(hash.has_deep_key?(:a)).to eq(true)
    expect(hash.has_deep_key?(:b)).to eq(false)
    expect(hash.has_deep_key?(:c)).to eq(false)
  end

  it 'removes unwanted keys from array of hashes' do
    instance.filter!([:a, :d], array)
    expect(array[0].has_deep_key?(:a)).to eq(true)
    expect(array[0].has_deep_key?(:b)).to eq(false)
    expect(array[0].has_deep_key?(:c)).to eq(false)
    expect(array[1].has_deep_key?(:d)).to eq(true)
    expect(array[1].has_deep_key?(:e)).to eq(false)
  end

  it 'recursively filters inputs tree' do
    instance.filter!([:a, :b], hash)
    expect(hash.has_deep_key?(:c)).to eq(false)
  end

  it 'filters inputs tree only on top level' do
    instance.filter!([:a, :b], hash, :recursive => false)
    expect(hash.has_deep_key?(:c)).to eq(true)
  end
end
