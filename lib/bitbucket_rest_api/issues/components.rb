# encoding: utf-8

module BitBucket
  class Issues::Components < API

    VALID_COMPONENT_INPUTS = %w[ name ].freeze

    # Creates new Issues::Components API
    def initialize(options = {})
      super(options)
    end
    # List all components for a repository
    #
    # = Examples
    #  bitbucket = BitBucket.new :user => 'user-name', :repo => 'repo-name'
    #  bitbucket.issues.components.list
    #  bitbucket.issues.components.list { |component| ... }
    #
    def list(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = get_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/components", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Get a single component
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.issues.components.find 'user-name', 'repo-name', 'component-id'
    #
    def get(user_name, repo_name, component_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of component_id
      normalize! params

      get_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/components/#{component_id}", params)
    end
    alias :find :get

    # Create a component
    #
    # = Inputs
    #  <tt>:name</tt> - Required string
    #
    # = Examples
    #  bitbucket = BitBucket.new :user => 'user-name', :repo => 'repo-name'
    #  bitbucket.issues.components.create :name => 'API'
    #
    def create(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?

      normalize! params
      filter! VALID_COMPONENT_INPUTS, params
      assert_required_keys(VALID_COMPONENT_INPUTS, params)

      post_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/components", params)
    end

    # Update a component
    #
    # = Inputs
    #  <tt>:name</tt> - Required string
    #
    # = Examples
    #  @bitbucket = BitBucket.new
    #  @bitbucket.issues.components.update 'user-name', 'repo-name', 'component-id',
    #    :name => 'API'
    #
    def update(user_name, repo_name, component_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of component_id

      normalize! params
      filter! VALID_COMPONENT_INPUTS, params
      assert_required_keys(VALID_COMPONENT_INPUTS, params)

      put_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/components/#{component_id}", params)
    end
    alias :edit :update

    # Delete a component
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.issues.components.delete 'user-name', 'repo-name', 'component-id'
    #
    def delete(user_name, repo_name, component_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?

      _validate_presence_of component_id
      normalize! params

      delete_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/components/#{component_id}", params)
    end

  end # Issues::Components
end # BitBucket
