# encoding: utf-8

module BitBucket
  class Repos::Services < API

    REQUIRED_KEY_PARAM_NAMES = %w[ type ].freeze

    # List services
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.services.list 'user-name', 'repo-name'
    #  bitbucket.repos.services.list 'user-name', 'repo-name' { |service| ... }
    #
    def list(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = get_request("/1.0/repositories/#{user}/#{repo.downcase}/services", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Gets a single service
    #
    # = Examples
    #  @bitbucket = BitBucket.new
    #  @bitbucket.repos.services.get 'user-name', 'repo-name', 109172378)
    #
    def get(user_name, repo_name, service_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of(service_id)
      normalize! params

      get_request("/1.0/repositories/#{user}/#{repo.downcase}/services/#{service_id}", params)
    end
    alias :find :get

    # Create a service
    #
    # = Inputs
    # * <tt>:type</tt> - One of the supported services. The type is a case-insensitive value.
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.services.create 'user-name', 'repo-name',
    #    "type"           => "Basecamp",
    #    "Password"       => "...",
    #    "Username"       => "...",
    #    "Discussion URL" => "..."
    #
    def create(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params
      assert_required_keys(REQUIRED_KEY_PARAM_NAMES, params)

      post_request("/1.0/repositories/#{user}/#{repo.downcase}/services", params)
    end

    # Edit a service
    #
    # = Inputs
    # * <tt>:type</tt> - One of the supported services. The type is a case-insensitive value.
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.services.edit 'user-name', 'repo-name', 109172378,
    #    "type"           => "Basecamp",
    #    "Password"       => "...",
    #    "Username"       => "...",
    #    "Discussion URL" => "..."
    #
    def edit(user_name, repo_name, service_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of(service_id)

      normalize! params

      put_request("/1.0/repositories/#{user}/#{repo.downcase}/services/#{service_id}", params)
    end

    # Delete service
    #
    # = Examples
    #  @bitbucket = BitBucket.new
    #  @bitbucket.repos.services.delete 'user-name', 'repo-name', 109172378
    #
    def delete(user_name, repo_name, service_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of(service_id)
      normalize! params

      delete_request("/1.0/repositories/#{user}/#{repo.downcase}/services/#{service_id}", params)
    end

  end # Repos::Keys
end # BitBucket
