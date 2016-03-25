# encoding: utf-8

module BitBucket
  class Repos::PullRequest < API

    # List pull requests
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.pull_request.list 'user-name', 'repo-name'
    #  bitbucket.repos.pull_request.list 'user-name', 'repo-name' { |status| ... }
    #
    def list(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = get_request("/2.0/repositories/#{user}/#{repo.downcase}/pullrequests", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # List pull request participants
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.pull_request.participants 'user-name', 'repo-name', 'number'
    #
    def participants(user_name, repo_name, pull_request_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = get_request("/1.0/repositories/#{user}/#{repo.downcase}/pullrequests/#{pull_request_id}/participants", params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    # List pull request commits
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.pull_request.commits 'user-name', 'repo-name', 'number'
    #
    def commits(user_name, repo_name, pull_request_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = get_request("/2.0/repositories/#{user}/#{repo.downcase}/pullrequests/#{pull_request_id}/commits", params)
      return response unless block_given?
      response.each { |el| yield el }
    end

  end # Repos::Keys
end # BitBucket
