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
      end

      it "supports get" do
        stub_request(:get, "https://bitbucket.org/api/1.0/repositories").
         with(:headers => {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer 12345',
          'User-Agent' => 'Faraday v0.9.2'
          })

        fake_api.new.request(:get, '/1.0/repositories', {}, {})
      end

      it "supports put" do
        stub_request(:put, "https://bitbucket.org/api/1.0/repositories").
         with(:body => { "data" => "payload" },
          :headers => {
            'Accept' => '*/*',
            'Content-Type'=>'application/x-www-form-urlencoded',
            'Authorization' => 'Bearer 12345',
            'User-Agent' => 'Faraday v0.9.2'
          })

        fake_api.new.request(:put, '/1.0/repositories', { :data => "payload" }, {})
      end

      it "supports patch" do
        stub_request(:patch, "https://bitbucket.org/api/1.0/repositories").
         with(:body => { "data" => "payload" },
          :headers => {
            'Accept' => '*/*',
            'Content-Type'=>'application/x-www-form-urlencoded',
            'Authorization' => 'Bearer 12345',
            'User-Agent' => 'Faraday v0.9.2'
          })

        fake_api.new.request(:patch, '/1.0/repositories', { :data => "payload" }, {})
      end

      it "supports delete" do
        stub_request(:delete, "https://bitbucket.org/api/1.0/repositories").
         with(:headers => {
          'Accept' => '*/*',
          'Authorization' => 'Bearer 12345',
          'User-Agent' => 'Faraday v0.9.2'
          })
        fake_api.new.request(:delete, '/1.0/repositories', {}, {})
      end

      it "supports post" do
        stub_request(:post, "https://bitbucket.org/api/1.0/repositories").
         with(:body => { "data" => "payload" },
          :headers => {
            'Accept' => '*/*',
            'Content-Type'=>'application/x-www-form-urlencoded',
            'Authorization' => 'Bearer 12345',
            'User-Agent' => 'Faraday v0.9.2'
          })

        fake_api.new.request(:post, '/1.0/repositories', { :data => "payload" }, {})
      end
    end
  end
end