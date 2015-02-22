# encoding: utf-8

module BitBucket
  class Issues::Milestones < API

    VALID_MILESTONE_INPUTS = %w[
      name
    ].freeze # :nodoc:

    # Creates new Issues::Milestones API
    def initialize(options = {})
      super(options)
    end

    # List milestones for a repository
    #
    # = Examples
    #  bitbucket = BitBucket.new :user => 'user-name', :repo => 'repo-name'
    #  bitbucket.issues.milestones.list
    #
    def list(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?

      normalize! params

      response = get_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/milestones", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Get a single milestone
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.issues.milestones.get 'user-name', 'repo-name', 'milestone-id'
    #
    def get(user_name, repo_name, milestone_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of milestone_id
      normalize! params

      get_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/milestones/#{milestone_id}", params)
    end
    alias :find :get

    # Create a milestone
    #
    # = Inputs
    #  <tt>:name</tt> - Required string
    #
    # = Examples
    #  bitbucket = BitBucket.new :user => 'user-name', :repo => 'repo-name'
    #  bitbucket.issues.milestones.create :name => 'hello-world'
    #
    def create(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?

      normalize! params
      filter! VALID_MILESTONE_INPUTS, params
      assert_required_keys(%w[ name ], params)

      post_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/milestones", params)
    end

    # Update a milestone
    #
    # = Inputs
    #  <tt>:name</tt> - Required string
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.issues.milestones.update 'user-name', 'repo-name', 'milestone-id',
    #    :name => 'hello-world'
    #
    def update(user_name, repo_name, milestone_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of milestone_id

      normalize! params
      filter! VALID_MILESTONE_INPUTS, params
      assert_required_keys(%w[ name ], params)

      put_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/milestones/#{milestone_id}", params)
    end

    # Delete a milestone
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.issues.milestones.delete 'user-name', 'repo-name', 'milestone-id'
    #
    def delete(user_name, repo_name, milestone_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of milestone_id
      normalize! params

      delete_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/milestones/#{milestone_id}", params)
    end

  end # Issues::Milestones
end # BitBucket