# encoding: utf-8

module BitBucket
  class User < API

    # Creates new User API
    def initialize(options = { })
      super(options)
    end

    # Gets the basic information associated with an account and 
    # a list of all of the repositories owned by the user.
    # See https://confluence.atlassian.com/display/BITBUCKET/user+Endpoint#userEndpoint-GETauserprofile
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.user.profile
    #
    def profile
      # TODO: verify oauth
      get_request("/user")
    end


  end # User
end # BitBucket
