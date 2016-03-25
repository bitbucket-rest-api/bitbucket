# encoding: utf-8

module BitBucket
  class Repos::Status < API

    # List pull requests
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.status.get 'user-name', 'repo-name', 'sha', 'yourapp'
    # params state	Yes
    # An indication of the status of the commit:
    # INPROGRESS indicates that a build for the commit is in progress but not yet complete.
    # SUCCESSFUL indicates that a build for the commit completed successfully.
    # FAILED indicates that a build for the commit failed.
    # key	Yes
    # A key that the vendor or build system supplies to identify the submitted build status. Because a single commit can involve multiple builds, the key needs to be unique compared to other builds associated with the commit.
    # For example, BAMBOO-PROJECT-X or JENKINS-BUILD-5.
    # name	No	The name of the build. Your build system may provide the name, which will also appear in Bitbucket. For example, Unit Tests.
    # url	Yes	The URL for the vendor or system that produces the build.
    # description	No	A user-defined description of the build. For example, 4 out of 128 tests passed.
    #
    def get(user_name, repo_name, sha, key, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = get_request("/2.0/repositories/#{user}/#{repo.downcase}/commit/#{sha}/statuses/build/#{key}", params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    def post(user_name, repo_name, sha, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params
      assert_required_keys(%w(description url state key), params)
      assert_required_values_present(
        params,
        'description',
        'url',
        'state',
        'key'
      )

      response = post_request("/2.0/repositories/#{user}/#{repo.downcase}/commit/#{sha}/statuses/build", params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    def put(user_name, repo_name, sha, key, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = put_request("/2.0/repositories/#{user}/#{repo.downcase}/commit/#{sha}/statuses/build/#{key}", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
  end
end