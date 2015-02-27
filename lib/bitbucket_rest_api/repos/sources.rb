# encoding: utf-8

module BitBucket
  class Repos::Sources < API

    REQUIRED_COMMENT_PARAMS = %w[
        body
        changeset_id
        line
        path
        position
      ].freeze

    # Gets a source of repo 
    #
    # = Examples
    #  @bitbucket = BitBucket.new
    #  @bitbucket.repos.sources.get 'user-name', 'repo-name', '6dcb09b5b57875f334f61aebed6', 'app/contorllers/')
    #
    def get(user_name, repo_name, sha, path, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of sha
      normalize! params

      get_request("/1.0/repositories/#{user}/#{repo.downcase}/src/#{sha}/#{path}", params)
    end
    alias :find :get

  end # Repos::Sources
end # BitBucket
