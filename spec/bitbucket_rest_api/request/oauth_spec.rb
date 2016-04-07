require 'spec_helper'
require 'rack/test'

describe BitBucket::Request::OAuth do
  include Rack::Test::Methods


  let(:app) { ->(env) { [200, env, "app"] } }

  let (:middleware) { BitBucket::Request::OAuth.new(app) }

  let(:request) { Rack::MockRequest.new(middleware) }

  it "add url key to env hash with URI value" do
    query_string = "key1=val1&key2=val2"
    code, env = middleware.call Rack::MockRequest.env_for("/?#{query_string}", {method: :post})
    expect(code).to eq 200
    expect(env[:url].query).to eq query_string
  end

  it "creates a empty hash if query of URI is empty" do
    code, env = middleware.call Rack::MockRequest.env_for("/", {method: :get})
    expect(code).to eq 200
    expect(middleware.query_params(env[:url])).to eq({})
  end
end

