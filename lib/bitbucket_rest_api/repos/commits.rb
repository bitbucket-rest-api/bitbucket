# encoding: utf-8

module BitBucket
  class Repos::Commits < API

    def get(user_name, repo_name)
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      get_request("/1.0/repositories/#{user}/#{repo.downcase}/commits")
    end


  end # Repos::Keys
end # BitBucket
