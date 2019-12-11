# encoding: utf-8

module BitBucket
  class Privileges < API
    extend AutoloadHelper

    def initialize(options = { })
      super(options)
    end

    def repo_list(user_name, repo_name, privilege_account = nil)
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?

      if privilege_account
        get_request("/1.0/privileges/#{user_name}/#{repo_name}/#{privilege_account}")
      else
        get_request("/1.0/privileges/#{user_name}/#{repo_name}")
      end
    end
  end
end
