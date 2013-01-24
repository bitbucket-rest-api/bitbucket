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
    #  <tt>:filter</tt> - Optional - See https://confluence.atlassian.com/display/BITBUCKET/Issues#Issues-Filtering for building the filter string
    #  <tt>:start</tt> - Optional - Issue offset, default 0
    #  <tt>:limit</tt> - Optional - Number of issues to retrieve, default 15
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

      response = get_request("/repositories/#{user}/#{repo}/issues", params)
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

      get_request("/repositories/#{user}/#{repo}/issues/#{issue_id}", params)
    end

    alias :find :get

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

      post_request("/repositories/#{user}/#{repo}/issues/", params)
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

      put_request("/repositories/#{user}/#{repo}/issues/#{issue_id}/", params)
    end

  end # Issues
end # BitBucket
