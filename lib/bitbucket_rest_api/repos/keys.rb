# encoding: utf-8

module BitBucket
  class Repos::Keys < API

    VALID_KEY_PARAM_NAMES = %w[ label key ].freeze

    # List deploy keys
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.keys.list 'user-name', 'repo-name'
    #  bitbucket.repos.keys.list 'user-name', 'repo-name' { |key| ... }
    #
    def list(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = get_request("/repositories/#{user}/#{repo}/deploy-keys/", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Create a key
    #
    # = Inputs
    # * <tt>:title</tt> - Required string.
    # * <tt>:key</tt> - Required string.
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.keys.create 'user-name', 'repo-name',
    #    "label" => "octocat@octomac",
    #    "key" =>  "ssh-rsa AAA..."
    #
    def create(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params
      filter! VALID_KEY_PARAM_NAMES, params
      assert_required_keys(VALID_KEY_PARAM_NAMES, params)

      post_request("/repositories/#{user}/#{repo}/deploy-keys/", params)
    end

    # Edit a key
    #
    # = Inputs
    # * <tt>:title</tt> - Required string.
    # * <tt>:key</tt> - Required string.
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.keys.edit 'user-name', 'repo-name',
    #    "label" => "octocat@octomac",
    #    "key" =>  "ssh-rsa AAA..."
    #
    def edit(user_name, repo_name, key_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of key_id

      normalize! params
      filter! VALID_KEY_PARAM_NAMES, params

      put_request("/repositories/#{user}/#{repo}/deploy-keys/#{key_id}", params)
    end

    # Delete key
    #
    # = Examples
    #  @bitbucket = BitBucket.new
    #  @bitbucket.repos.keys.delete 'user-name', 'repo-name', 'key-id'
    #
    def delete(user_name, repo_name, key_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of key_id
      normalize! params

      delete_request("/repositories/#{user}/#{repo}/deploy-keys/#{key_id}", params)
    end

  end # Repos::Keys
end # BitBucket
