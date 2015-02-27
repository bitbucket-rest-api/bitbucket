# encoding: utf-8

module BitBucket
  class Users::Account < API

    # API about users/account , please refer to 
    # https://confluence.atlassian.com/display/BITBUCKET/account+Resource
    #  


    # GET the account profile
    # 
    def profile(accountname)
      response = get_request("/1.0/users/#{accountname}")
    end

    # GET the account plan
    def plan(accountname)
      response = get_request("/1.0/users/#{accountname}/plan")
    end

    # GET the emails
    def emails(accountname)
      response = get_request("/1.0/users/#{accountname}/emails")
    end

    # GET the followers
    def followers(accountname)
      response = get_request("/1.0/users/#{accountname}/followers")
    end

    # GET the events
    def events(accountname)
      response = get_request("/1.0/users/#{accountname}/events")
    end

    #GET the keys
    def keys(accountname)
      response = get_request("/1.0/users/#{accountname}/ssh-keys")
    end

    #POST a new key
    # params should be in format {key: "", label:""}
    def new_key(accountname, params)
      response = post_request("/1.0/users/#{accountname}/ssh-keys/", params)
    end

    #DELETE a key
    def delete_key(accountname, key_id)
      response = delete_request("/1.0/users/#{accountname}/ssh-keys/#{key_id}")
    end
  end # Users::Account
end # BitBucket
