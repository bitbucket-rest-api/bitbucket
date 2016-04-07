# encoding: utf-8

module BitBucket
  class Repos::Download < API
    REQUIRED_KEY_PARAM_NAMES = %w[ commit_hash ].freeze
    def get(user_name, repo_name, params={})
          _update_user_repo_params(user_name, repo_name)
          _validate_user_repo_params(user, repo) unless user? && repo?
    #       normalize! params
    #       assert_required_keys(REQUIRED_KEY_PARAM_NAMES, params)

    #https://bitbucket.org/jhanley85/eternum_canvas_demo/get/fd931f96f12d.zip
      "https://bitbucket.org/#{user}/#{repo.downcase}/get/#{params[:commit_hash]}.tar.gz"
    end





  end # Repos::Keys
end # BitBucket
