# encoding: utf-8

module BitBucket
  class Repos::Sources < API

    # Gets a list of the src in a repository.
    #
    # = Examples
    #  @bitbucket = BitBucket.new
    #  @bitbucket.repos.sources.list 'user-name', 'repo-name', '6dcb09b5b57875f334f61aebed6', 'app/contorllers/')
    #
    def list(user_name, repo_name, sha, path)
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of(sha, path)

      get_request("/1.0/repositories/#{user}/#{repo.downcase}/src/#{sha}/#{path}")
    end
    alias :all :list

    # Gets information about an individual file. This method returns the file's
    # size and contents.  If the file is encoded, this method returns the files
    # encoding; Currently, Bitbucket supports only base64 encoding.
    #
    # = Examples
    #  @bitbucket = BitBucket.new
    #  @bitbucket.repos.sources.get 'user-name', 'repo-name', '6dcb09b5b57875f334f61aebed6', 'app/assets/images/logo.jpg')
    #
    def get(user_name, repo_name, sha, path)
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of(sha, path)

      get_request("/1.0/repositories/#{user}/#{repo.downcase}/raw/#{sha}/#{path}")
    end
    alias :find :get

  end # Repos::Sources
end # BitBucket
