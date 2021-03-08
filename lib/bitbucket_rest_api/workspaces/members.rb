# encoding: utf-8

module BitBucket
  class Workspaces::Members < API

    # API about workspaces/members , please refer to 
    # https://developer.atlassian.com/bitbucket/api/2/reference/resource/workspaces/%7Bworkspace%7D/members
    #  


    # GET the workspace members
    # 
    def list(workspace)
      get_request("/2.0/workspaces/#{workspace}/members")
    end
  end # Workspaces::Members
end # BitBucket
