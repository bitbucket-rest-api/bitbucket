require 'spec_helper'

describe BitBucket::Response::Jsonize do
  let(:jsonize) { described_class.new }
  before do
    @body = "{\"key1\":\"val1\"}"
  end

  it "parses the json and returns a hash" do
    expect(jsonize.parse(@body)).to eq({"key1"=>"val1"})
  end
end
