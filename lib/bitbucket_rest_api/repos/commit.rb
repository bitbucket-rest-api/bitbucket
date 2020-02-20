# encoding: utf-8

module BitBucket
  class Repos::Commit < API

    def get(user_name, repo_name, revision)
        _update_user_repo_params(user_name, repo_name)
        _validate_user_repo_params(user, repo) unless user? && repo?

        path = "/2.0/repositories/#{user}/#{repo.downcase}/commit/#{revision}"
        get_request(path)
    end

  end # Repos::Commits
end # BitBucket
