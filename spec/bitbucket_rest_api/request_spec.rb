require 'spec_helper'
require 'bitbucket_rest_api/request'

describe BitBucket::Request do
  let(:fake_api) { (Class.new { include BitBucket::Request })}
  let(:faraday_connection) { Faraday.new(:url => 'https://bitbucket.org/api') }

  describe "request" do
    it "raises an ArgumentError if an unsupported HTTP verb is used" do
      expect { fake_api.new.request(:i_am_a_teapot, '/', {}, {}) }.to raise_error(ArgumentError)
    end

    context "with a connection" do
      before do
        (fake_api).any_instance.stubs(:connection).returns(faraday_connection)
        (fake_api).any_instance.stubs(:new_access_token).returns("12345")

        stub_request(:get, "https://bitbucket.org/api/1.0/repositories").
         with(:headers => {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer 12345',
          'User-Agent' => 'Faraday v0.9.2'
          })
      end

      it "doesn't raise for a get" do
        fake_api.new.request(:get, '/1.0/repositories', {}, {})
      end
    end
  end
end