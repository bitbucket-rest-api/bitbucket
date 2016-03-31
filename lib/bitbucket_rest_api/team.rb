# encoding: utf-8

module BitBucket
  class Team < API
    extend AutoloadHelper

    def initialize(options = { })
      super(options)
    end

    def list(user_role)
      response = get_request("/2.0/teams/?role=#{user_role.to_s}")
      return response unless block_given?
      response["values"].each { |el| yield el }
    end

    def profile(team_name)
      get_request("/2.0/teams/#{team_name.to_s}")
    end

  end # Users
end # BitBucket
