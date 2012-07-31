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
    # * <tt>:sha</tt>   Optional string. Sha or branch to start listing changesets from.
    # * <tt>:path</tt>  Optional string. Only changesets containing this file path will be returned
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.changesets.list 'user-name', 'repo-name', :sha => '...'
    #  bitbucket.repos.changesets.list 'user-name', 'repo-name', :sha => '...' { |changeset| ... }
    #
    def list(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params
      filter! %w[ sha path], params

      response = get_request("/repositories/#{user}/#{repo}/changesets", params)
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

      get_request("/repositories/#{user}/#{repo}/changesets/#{sha}", params)
    end
    alias :find :get

  end # Repos::Commits
end # BitBucket