require 'spec_helper'

describe BitBucket::Request::Jsonize do
  let(:jsonize) { described_class.new(lambda { |env| env }) }
  before do
    @env = {
      body: {key1: 'val1'},
      request_headers: {
        'Content-Type' => 'application/json; charset=utf-8'
      }
    }
  end

  it "converts the body to json" do
    expected = {body: "{\"key1\":\"val1\"}", request_headers: {"Content-Type"=>"application/json; charset=utf-8"}}
    expect(jsonize.call(@env)).to eq expected
  end
end
