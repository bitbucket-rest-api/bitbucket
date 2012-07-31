# encoding: utf-8

require 'faraday'

module BitBucket
  module Request
    class OAuth < Faraday::Middleware
      include BitBucket::Utils::Url

      ACCESS_TOKEN = 'access_token'.freeze
      AUTH_HEADER  = 'Authorization'.freeze

      dependency 'oauth'

      def call(env)
        # Extract parameters from the query
        params = {  }.update query_params(env[:url])

        if (@token and @secret) and (!@token.empty? and !@secret.empty?)
          env[:url].query = build_query params

          access_token = ::OAuth::AccessToken.new(@consumer, @token, @secret)
          oauth_params = {:consumer => @consumer, :token => access_token}
          req = case env[:method]
                  when :post
                    Net::HTTP::Post.new env[:url].to_s
                  when :put
                    Net::HTTP::Put.new env[:url].to_s
                  when :delete
                    Net::HTTP::Delete.new env[:url].to_s
                  when :patch
                    Net::HTTP::Patch.new env[:url].to_s
                  else
                    Net::HTTP::Get.new env[:url].to_s
                end
          puts req
          oauth_helper = ::OAuth::Client::Helper.new(req, oauth_params.merge(:request_uri => env[:url].to_s))
          env[:request_headers].merge!(AUTH_HEADER => oauth_helper.header)
        end

        @app.call env
      end

      def initialize(app, *args)
        super app
        @app = app
        @consumer = args.shift
        @token = args.shift
        @secret = args.shift
      end

      def query_params(url)
        if url.query.nil? or url.query.empty?
          {}
        else
          parse_query url.query
        end
      end
    end # OAuth
  end # Request
end # BitBucket
