# encoding: utf-8

module BitBucket
  class Repos::Pipelines < API
    # Gets the pipelines information associated with a repository.
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.pipelines.list 'user-name', 'repo-name'
    #  bitbucket.repos.pipelines.list 'user-name', 'repo-name', 'master'
    #  bitbucket.repos.pipelines.list 'user-name', 'repo-name' { |key| ... }
    #
    def list(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      path = "/2.0/repositories/#{user}/#{repo.downcase}/pipelines/"
      response = get_request(path, params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Gets the pipelines config information associated with a repository.
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.pipelines.config 'user-name', 'repo-name'
    #  bitbucket.repos.pipelines.config 'user-name', 'repo-name', 'master'
    #  bitbucket.repos.pipelines.config 'user-name', 'repo-name' { |key| ... }
    #
    def config(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      path = "/2.0/repositories/#{user}/#{repo.downcase}/pipelines_config"
      response = get_request(path, params)
      return response unless block_given?
      response.each { |el| yield el }
    end

  end # Repos::Pipelines
end # BitBucket
