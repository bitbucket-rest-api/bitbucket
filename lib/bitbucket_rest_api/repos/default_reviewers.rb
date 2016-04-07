module BitBucket
  class Repos::DefaultReviewers < API

    # List default reviewers
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.default_reviewers.list 'user-name', 'repo-name'
    #  bitbucket.repos.default_reviewers.list 'user-name', 'repo-name' { |reviewer| ... }
    #
    def list(user_name, repo_name, params={})
      update_and_validate_user_repo_params(user_name, repo_name)
      normalize! params

      response = get_request("/2.0/repositories/#{user_name}/#{repo_name}/default-reviewers", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Get a default reviewer's info
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.default_reviewers.get 'user-name', 'repo-name', 'reviewer-username'
    #
    def get(user_name, repo_name, reviewer_username, params={})
      update_and_validate_user_repo_params(user_name, repo_name)
      normalize! params

      get_request("/2.0/repositories/#{user_name}/#{repo_name}/default-reviewers/#{reviewer_username}", params)
    end

    # Add a user to the default-reviewers list for the repo
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.default_reviewers.add 'user-name', 'repo-name', 'reviewer-username'
    #
    def add(user_name, repo_name, reviewer_username, params={})
      update_and_validate_user_repo_params(user_name, repo_name)
      normalize! params

      put_request("/2.0/repositories/#{user_name}/#{repo_name}/default-reviewers/#{reviewer_username}", params)
    end

    # Remove a user from the default-reviewers list for the repo
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.default_reviewers.remove 'user-name', 'repo-name', 'reviewer-username'
    #
    def remove(user_name, repo_name, reviewer_username, params={})
      update_and_validate_user_repo_params(user_name, repo_name)
      normalize! params
      delete_request("/2.0/repositories/#{user_name}/#{repo_name}/default-reviewers/#{reviewer_username}", params)
    end
  end
end
