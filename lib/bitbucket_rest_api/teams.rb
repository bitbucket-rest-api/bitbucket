# encoding: utf-8

module BitBucket
  class Teams < API
    extend AutoloadHelper

    def initialize(options = { })
      super(options)
    end

    def list(user_role)
      response = get_request("/2.0/teams/?role=#{user_role.to_s}")
      return response["values"] unless block_given?
      response["values"].each { |el| yield el }
    end

    alias :all :list

    def profile(team_name)
      get_request("/2.0/teams/#{team_name.to_s}")
    end

    def members(team_name)
      response = get_request("/2.0/teams/#{team_name.to_s}/members")
      return response["values"] unless block_given?
      response["values"].each { |el| yield el }
    end

    def followers(team_name)
      response = get_request("/2.0/teams/#{team_name.to_s}/followers")
      return response["values"] unless block_given?
      response["values"].each { |el| yield el }
    end

    def following(team_name)
      response = get_request("/2.0/teams/#{team_name.to_s}/following")
      return response["values"] unless block_given?
      response["values"].each { |el| yield el }
    end

    def repos(team_name)
      response = get_request("/2.0/repositories/#{team_name.to_s}")
      return response["values"] unless block_given?
      response["values"].each { |el| yield el }
    end

    alias :repositories :repos

  end # Team
end # BitBucket
