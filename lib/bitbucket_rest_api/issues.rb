# encoding: utf-8

module BitBucket
  class Issues < API
    extend AutoloadHelper

    autoload_all 'bitbucket_rest_api/issues',
                 :Comments   => 'comments',
                 :Components => 'components',
                 :Milestones => 'milestones'

    VALID_ISSUE_PARAM_NAMES = %w[
      title
      content
      component
      milestone
      version
      responsible
      priority
      status
      kind
      limit
      start
      search
      sort
      reported_by
    ].freeze

    VALID_ISSUE_PARAM_VALUES = {
        'priority'    => %w[ trivial minor major critical blocker ],
        'status'     => ['new', 'open', 'resolved', 'on hold', 'invalid', 'duplicate', 'wontfix'],
        'kind'      => %w[ bug enhancement proposal task ]
    }

    # Creates new Issues API
    def initialize(options = { })
      super(options)
    end

    # Access to Issues::Comments API
    def comments
      @comments ||= ApiFactory.new 'Issues::Comments'
    end

    # Access to Issues::Components API
    def components
      @components ||= ApiFactory.new 'Issues::Components'
    end

    # Access to Issues::Milestones API
    def milestones
      @milestones ||= ApiFactory.new 'Issues::Milestones'
    end

    # List issues for a repository
    #
    # = Inputs
    #  <tt>:limit</tt> - Optional - Number of issues to retrieve, default 15
    #  <tt>:start</tt> - Optional - Issue offset, default 0
    #  <tt>:search</tt> - Optional - A string to search for
    #  <tt>:sort</tt> - Optional - Sorts the output by any of the metadata fields
    #  <tt>:title</tt> - Optional - Contains a filter operation to restrict the list of issues by the issue title
    #  <tt>:content</tt> - Optional - Contains a filter operation to restrict the list of issues by the issue content
    #  <tt>:version</tt> - Optional - Contains an is or ! ( is not) filter to restrict the list of issues by the version
    #  <tt>:milestone</tt> - Optional - Contains an is or ! ( is not) filter to restrict the list of issues by the milestone
    #  <tt>:component</tt> - Optional - Contains an is or ! ( is not) filter to restrict the list of issues by the component
    #  <tt>:kind</tt> - Optional - Contains an is or ! ( is not) filter to restrict the list of issues by the issue kind
    #  <tt>:status</tt> - Optional - Contains an is or ! ( is not) filter to restrict the list of issues by the issue status
    #  <tt>:responsible</tt> - Optional - Contains an is or ! ( is not) filter to restrict the list of issues by the user responsible
    #  <tt>:reported_by</tt> - Optional - Contains a filter operation to restrict the list of issues by the user that reported the issue
    #
    # = Examples
    #  bitbucket = BitBucket.new :user => 'user-name', :repo => 'repo-name'
    #  bitbucket.issues.list_repo :filter => 'kind=bug&kind=enhancement'
    #
    def list_repo(user_name, repo_name, params={ })
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?

      normalize! params
      filter! VALID_ISSUE_PARAM_NAMES, params
      # _merge_mime_type(:issue, params)
      assert_valid_values(VALID_ISSUE_PARAM_VALUES, params)

      response = get_request("/1.0/repositories/#{user}/#{repo.downcase}/issues", params)
      return response.issues unless block_given?
      response.issues.each { |el| yield el }
    end

    alias :list_repository :list_repo

    # Get a single issue
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.issues.get 'user-name', 'repo-name', 'issue-id'
    #
    def get(user_name, repo_name, issue_id, params={ })
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of issue_id

      normalize! params
      # _merge_mime_type(:issue, params)

      get_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/#{issue_id}", params)
    end

    alias :find :get

    # Delete a single issue
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.issues.delete 'user-name', 'repo-name', 'issue-id'
    #
    def delete(user_name, repo_name, issue_id, params={ })
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of issue_id

      normalize! params
      # _merge_mime_type(:issue, params)

      delete_request("/1.0/repositories/#{user}/#{repo}/issues/#{issue_id}", params)
    end

    # Create an issue
    #
    # = Inputs
    #  <tt>:title</tt> - Required string
    #  <tt>:content</tt> - Optional string
    #  <tt>:responsible</tt> - Optional string - Login for the user that this issue should be assigned to.
    #  <tt>:milestone</tt> - Optional number - Milestone to associate this issue with
    #  <tt>:version</tt> - Optional number - Version to associate this issue with
    #  <tt>:component</tt> - Optional number - Component to associate this issue with
    #  <tt>:priority</tt> - Optional string - The priority of this issue
    #  * <tt>trivial</tt>
    #  * <tt>minor</tt>
    #  * <tt>major</tt>
    #  * <tt>critical</tt>
    #  * <tt>blocker</tt>
    #  <tt>:status</tt> - Optional string - The status of this issue
    #  * <tt>new</tt>
    #  * <tt>open</tt>
    #  * <tt>resolved</tt>
    #  * <tt>on hold</tt>
    #  * <tt>invalid</tt>
    #  * <tt>duplicate</tt>
    #  * <tt>wontfix</tt>
    #  <tt>:kind</tt> - Optional string - The kind of issue
    #  * <tt>bug</tt>
    #  * <tt>enhancement</tt>
    #  * <tt>proposal</tt>
    #  * <tt>task</tt>
    #
    # = Examples
    #  bitbucket = BitBucket.new :user => 'user-name', :repo => 'repo-name'
    #  bitbucket.issues.create
    #    "title" => "Found a bug",
    #    "content" => "I'm having a problem with this.",
    #    "responsible" => "octocat",
    #    "milestone" => 1,
    #    "priority" => "blocker"
    #
    def create(user_name, repo_name, params={ })
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?

      normalize! params
      _merge_user_into_params!(params) unless params.has_key?('user')
      # _merge_mime_type(:issue, params)
      filter! VALID_ISSUE_PARAM_NAMES, params
      assert_required_keys(%w[ title ], params)

      post_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/", params)
    end

    # Edit an issue
    #
    # = Inputs
    #  <tt>:title</tt> - Required string
    #  <tt>:content</tt> - Optional string
    #  <tt>:responsible</tt> - Optional string - Login for the user that this issue should be assigned to.
    #  <tt>:milestone</tt> - Optional number - Milestone to associate this issue with
    #  <tt>:version</tt> - Optional number - Version to associate this issue with
    #  <tt>:component</tt> - Optional number - Component to associate this issue with
    #  <tt>:priority</tt> - Optional string - The priority of this issue
    #  * <tt>trivial</tt>
    #  * <tt>minor</tt>
    #  * <tt>major</tt>
    #  * <tt>critical</tt>
    #  * <tt>blocker</tt>
    #  <tt>:status</tt> - Optional string - The status of this issue
    #  * <tt>new</tt>
    #  * <tt>open</tt>
    #  * <tt>resolved</tt>
    #  * <tt>on hold</tt>
    #  * <tt>invalid</tt>
    #  * <tt>duplicate</tt>
    #  * <tt>wontfix</tt>
    #  <tt>:kind</tt> - Optional string - The kind of issue
    #  * <tt>bug</tt>
    #  * <tt>enhancement</tt>
    #  * <tt>proposal</tt>
    #  * <tt>task</tt>
    #
    # = Examples
    #  bitbucket = BitBucket.new :user => 'user-name', :repo => 'repo-name'
    #  bitbucket.issues.create
    #    "title" => "Found a bug",
    #    "content" => "I'm having a problem with this.",
    #    "responsible" => "octocat",
    #    "milestone" => 1,
    #    "priority" => "blocker"
    #
    def edit(user_name, repo_name, issue_id, params={ })
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of issue_id

      normalize! params
      # _merge_mime_type(:issue, params)
      filter! VALID_ISSUE_PARAM_NAMES, params

      put_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/#{issue_id}/", params)
    end

  end # Issues
end # BitBucket
