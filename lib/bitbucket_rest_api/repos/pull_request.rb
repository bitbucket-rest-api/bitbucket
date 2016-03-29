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
    #  bitbucket.repos.pull_request.list 'user-name', 'repo-name'
    #  bitbucket.repos.pull_request.list 'user-name', 'repo-name' { |status| ... }
    #
    def participants(user_name, repo_name, pull_request_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = get_request("/1.0/repositories/#{user}/#{repo.downcase}/pullrequests/#{pull_request_id}/participants", params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    def get(user_name, repo_name, pull_request_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = request(:get, "/2.0/repositories/#{user}/#{repo.downcase}/pullrequests/#{pull_request_id}", params)
      return response unless block_given?
    end

    def create(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = request(:post, "/2.0/repositories/#{user}/#{repo.downcase}/pullrequests", params)
      return response unless block_given?
    end

    def update(user_name, repo_name, pull_request_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = request(:put, "/2.0/repositories/#{user}/#{repo.downcase}/pullrequests/#{pull_request_id}", params)
      return response unless block_given?
    end

    def commits(user_name, repo_name, pull_request_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = request(:get, "/2.0/repositories/#{user}/#{repo.downcase}/pullrequests/#{pull_request_id}/commits", params)
      return response unless block_given?
    end

    def approve(user_name, repo_name, pull_request_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = request(:post, "/2.0/repositories/#{user}/#{repo.downcase}/pullrequests/#{pull_request_id}/approve", params)
      return response unless block_given?
    end

    def delete_approval(user_name, repo_name, pull_request_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = request(:delete, "/2.0/repositories/#{user}/#{repo.downcase}/pullrequests/#{pull_request_id}/approve", params)
      return response unless block_given?
    end

    def diff(user_name, repo_name, pull_request_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = request(:get, "/2.0/repositories/#{user}/#{repo.downcase}/pullrequests/#{pull_request_id}/diff", params)
      return response unless block_given?
    end


    def all_activity(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = request(:get, "/2.0/repositories/#{user}/#{repo.downcase}/pullrequests/activity", params)
      return response unless block_given?
    end


    def activity(user_name, repo_name, pull_request_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = request(:get, "/2.0/repositories/#{user}/#{repo.downcase}/pullrequests/#{pull_request_id}/activity", params)
      return response unless block_given?
    end

    def merge(user_name, repo_name, pull_request_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = request(:post, "/2.0/repositories/#{user}/#{repo.downcase}/pullrequests/#{pull_request_id}/merge", params)
      return response unless block_given?
    end

    def decline(user_name, repo_name, pull_request_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = request(:post, "/2.0/repositories/#{user}/#{repo.downcase}/pullrequests/#{pull_request_id}/decline", params)
      return response unless block_given?
    end

    def comments(user_name, repo_name, pull_request_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = request(:get, "/2.0/repositories/#{user}/#{repo.downcase}/pullrequests/#{pull_request_id}/comments", params)
      return response unless block_given?
    end

    def comment(user_name, repo_name, pull_request_id, comment_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = request(:get, "/2.0/repositories/#{user}/#{repo.downcase}/pullrequests/#{pull_request_id}/comments/#{comment_id}", params)
      return response unless block_given?
    end
  end # Repos::Keys
end # BitBucket
