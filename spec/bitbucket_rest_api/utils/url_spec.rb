require 'spec_helper'

describe BitBucket::Utils::Url do
  before do
      @url_util = BitBucket::Utils::Url
    end

  describe '.build_query' do
    it 'builds a query string from a params hash' do
      expect(@url_util.build_query({key1: "val1", key2: "val2"})).to eq "key1=val1&key2=val2"
    end

    it 'builds a query string from a params hash when one value is an array' do
      expect(@url_util.build_query({key1: "val1", key2: ["val2", "val3"]})).to eq "key1=val1&key2=val2&key2=val3"
    end
  end

  describe '.parse_query' do
    it 'builds a params hash from a query string' do
      expect(@url_util.parse_query("key1=val1&key2=val2")).to eq({"key1" => "val1", "key2" => "val2"})
    end

    it 'builds a params hash from a query string when given multiple values for the same param' do
      expect(@url_util.parse_query("key1=val1&key2=val2&key2=val3&key2=val4")).to eq({"key1" => "val1", "key2" => ["val2", "val3", "val4"]})
    end
  end

  describe '.parse_query_for_param' do
    it 'returns a value a query string given the key' do
      expect(@url_util.parse_query_for_param("key1=val1&key2=val2", "key2")).to eq("val2")
    end
  end
end
