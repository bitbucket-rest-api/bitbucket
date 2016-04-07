# encoding: utf-8

require 'spec_helper'

describe Hash do

  before do
    BitBucket.new
    @hash = { :a => 1, :b => 2, :c => 'e'}
    @serialized = "a=1&b=2&c=e"
    @nested_hash = { 'a' => { 'b' => {'c' => 1 } } }
    @symbols = { :a => { :b => { :c => 1 } } }
  end

  context '#symbolize_keys' do
    it 'should respond to symbolize_keys' do
      expect(@nested_hash).to respond_to :symbolize_keys
    end
  end

  context '#symbolize_keys!' do
    it 'should respond to symbolize_keys!' do
      expect(@nested_hash).to respond_to :symbolize_keys!
    end

    it 'should convert nested keys to symbols' do
      expect(@nested_hash.symbolize_keys!).to eq @symbols

      @nested_hash_with_array = { 'a' => { 'b' => [{'c' => 1}] } }
      expect(@nested_hash_with_array.symbolize_keys!).to eq({:a=>{:b=>[{:c=>1}]}})
    end
  end

  context '#serialize' do
    it 'should respond to serialize' do
      expect(@nested_hash).to respond_to :serialize
    end

    it 'should serialize hash' do
      expect(@hash.serialize).to eq @serialized
    end
  end

  context '#deep_key?' do
    it 'should find key inside nested hash' do
      expect(@nested_hash.has_deep_key?('c')).to be_truthy
    end
  end
end # Hash
