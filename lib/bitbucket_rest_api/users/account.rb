# encoding: utf-8

module BitBucket
  class Users::Account < API

    # API about users/account , please refer to 
    # https://confluence.atlassian.com/display/BITBUCKET/account+Resource
    #  


    # GET the account profile
    # 
    def profile(accountname)
      response = get_request("/users/#{accountname}")
    end

    # GET the account plan
    def plan(accountname)
      response = get_request("/users/#{accountname}/plan")
    end

    # GET the followers
    def followers(accountname)
      response = get_request("/users/#{accountname}/followers")
    end

    # GET the events
    def events(accountname)
      response = get_request("/users/#{accountname}/events")
    end

  end # Users::Account
end # BitBucket