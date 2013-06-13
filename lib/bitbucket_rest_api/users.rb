# encoding: utf-8

module BitBucket
  class Users < API
    extend AutoloadHelper

    # Load all the modules after initializing Repos to avoid superclass mismatch
    autoload_all 'bitbucket_rest_api/users',
                 :Account       => 'account'


    # Creates new Users API
    def initialize(options = { })
      super(options)
    end

    # Access to Users::Account API
    def account
      @account ||= ApiFactory.new 'Users::Account'
    end


  end # Users
end # BitBucket
