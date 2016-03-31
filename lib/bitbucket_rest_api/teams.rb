# encoding: utf-8

module BitBucket
  class Teams < API
    extend AutoloadHelper

    def initialize(options = { })
      super(options)
    end

    # List teams for the authenticated user where the user has the provided role
    # Roles are :admin, :contributor, :member
    #
    # = Examples
    #   bitbucket = BitBucket.new :oauth_token => '...', :oauth_secret => '...'
    #   Teams.new.list(:admin)
    #   Teams.new.list('member')
    #   Teams.new.list(:contributor) { |team| ... }
    def list(user_role)
      response = get_request("/2.0/teams/?role=#{user_role.to_s}")
      return response["values"] unless block_given?
      response["values"].each { |el| yield el }
    end

    alias :all :list

    # Return the profile for the provided team
    #
    # = Example
    #   bitbucket = BitBucket.new :oauth_token => '...', :oauth_secret => '...'
    #   Teams.new.profile(:team_name_here)
    def profile(team_name)
      get_request("/2.0/teams/#{team_name.to_s}")
    end

    # List members of the provided team
    #
    # = Examples
    #   bitbucket = BitBucket.new :oauth_token => '...', :oauth_secret => '...'
    #   Teams.new.members(:team_name_here)
    #   Teams.new.members(:team_name_here) { |member| ... }
    def members(team_name)
      response = get_request("/2.0/teams/#{team_name.to_s}/members")
      return response["values"] unless block_given?
      response["values"].each { |el| yield el }
    end

    # List followers of the provided team
    #
    # = Examples
    #   bitbucket = BitBucket.new :oauth_token => '...', :oauth_secret => '...'
    #   Teams.new.followers(:team_name_here)
    #   Teams.new.followers(:team_name_here) { |follower| ... }
    def followers(team_name)
      response = get_request("/2.0/teams/#{team_name.to_s}/followers")
      return response["values"] unless block_given?
      response["values"].each { |el| yield el }
    end

    # List accounts following the provided team
    #
    # = Examples
    #   bitbucket = BitBucket.new :oauth_token => '...', :oauth_secret => '...'
    #   Teams.new.following(:team_name_here)
    #   Teams.new.following(:team_name_here) { |followee| ... }
    def following(team_name)
      response = get_request("/2.0/teams/#{team_name.to_s}/following")
      return response["values"] unless block_given?
      response["values"].each { |el| yield el }
    end

    # List repos for provided team
    # Private repos will only be returned if the user is authorized to view them
    #
    # = Examples
    #   bitbucket = BitBucket.new :oauth_token => '...', :oauth_secret => '...'
    #   Teams.new.repos(:team_name_here)
    #   Teams.new.repos(:team_name_here) { |repo| ... }
    def repos(team_name)
      response = get_request("/2.0/repositories/#{team_name.to_s}")
      return response["values"] unless block_given?
      response["values"].each { |el| yield el }
    end

    alias :repositories :repos

  end # Team
end # BitBucket
