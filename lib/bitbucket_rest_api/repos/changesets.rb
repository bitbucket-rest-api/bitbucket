# encoding: utf-8

module BitBucket
  class Repos::Changesets < API

    REQUIRED_COMMENT_PARAMS = %w[
        body
        changeset_id
        line
        path
        position
      ].freeze

    # List changesets on a repository
    #
    # = Parameters
    # * <tt>:limit</tt> Optional integer. An integer representing how many changesets to return. You can specify a limit between 0 and 50.
    # * <tt>:start</tt> Optional string. A hash value representing the earliest node to start with.
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.changesets.list 'user-name', 'repo-name', :start => '...'
    #  bitbucket.repos.changesets.list 'user-name', 'repo-name', :start => '...' { |changeset| ... }
    #
    def list(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params
      filter! %w[ limit start], params

      response = get_request("/1.0/repositories/#{user}/#{repo.downcase}/changesets", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Gets a single changeset
    #
    # = Examples
    #  @bitbucket = BitBucket.new
    #  @bitbucket.repos.changesets.get 'user-name', 'repo-name', '6dcb09b5b57875f334f61aebed6')
    #
    def get(user_name, repo_name, sha, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of sha
      normalize! params

      get_request("/1.0/repositories/#{user}/#{repo.downcase}/changesets/#{sha}", params)
    end
    alias :find :get

  end # Repos::Commits
end # BitBucket