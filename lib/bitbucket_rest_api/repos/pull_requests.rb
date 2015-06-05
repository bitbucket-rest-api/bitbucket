# encoding: utf-8

module BitBucket
  class Repos::PullRequests < API

    # List services
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.repositories.list 'user-name', 'repo-name'
    #  bitbucket.repos.repositories.list 'user-name', 'repo-name' { |status| ... }
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

  end # Repos::Keys
end # BitBucket
