# encoding: utf-8

require 'faraday'

module BitBucket
  module Request
    class OAuth < Faraday::Middleware
      include BitBucket::Utils::Url

      AUTH_HEADER  = 'Authorization'.freeze

      dependency 'simple_oauth'

      def call(env)
        # Extract parameters from the query
        request = Rack::Request.new env
        env[:url] = URI.parse(request.url) if env[:url].nil?
        params = {  }.update query_params(env[:url])

        if (@token and @secret) and (!@token.empty? and !@secret.empty?)
          access_token = ::OAuth::AccessToken.new(@consumer, @token, @secret)
          env[:url].query = build_query params

          puts oauth_helper.header
          puts oauth_helper.header.class
          env[:request_headers].merge!(AUTH_HEADER => oauth_helper.header)
        end

          env[:url].query = build_query params



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
