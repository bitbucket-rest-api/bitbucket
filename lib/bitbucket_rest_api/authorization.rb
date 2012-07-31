# encoding: utf-8

module BitBucket
  module Authorization

    # Setup OAuth instance
    def client
      @client ||= ::OAuth::Consumer.new(client_id, client_secret,
                                      {:signature_method=>"HMAC-SHA1",
                                       :request_token_path=>"/1.0/oauth/request_token",
                                       :authorize_path=>"/1.0/oauth/authenticate",
                                       :access_token_path=>"/1.0/oauth/access_token",
                                       :proxy=>nil,
                                       :scheme=>:header,
                                       :http_method=>:post,
                                       :oauth_version=>"1.0",
                                       :site=>"https://api.bitbucket.org"}
      )
    end

    # Check whether authentication credentials are present
    def authenticated?
      basic_authed? || oauth_token?
    end

    # Check whether basic authentication credentials are present
    def basic_authed?
      basic_auth? || (login? && password?)
    end

    # Select authentication parameters
    def authentication
      if basic_auth?
        { :basic_auth => basic_auth }
      elsif login? && password?
        { :login => login, :password => password }
      else
        { }
      end
    end

    private

    def _verify_client # :nodoc:
      raise ArgumentError, 'Need to provide client_id and client_secret' unless client_id? && client_secret?
    end

  end # Authorization
end # BitBucket
