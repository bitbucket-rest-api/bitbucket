# encoding: utf-8

module BitBucket
  class Repos < API
    extend AutoloadHelper

    # Load all the modules after initializing Repos to avoid superclass mismatch
    autoload_all 'bitbucket_rest_api/repos',
                 :Changesets  => 'changesets',
                 :Keys        => 'keys',
                 :Services    => 'services',
                 :Following   => 'following',
                 :Sources     => 'sources',
                 :Forks       => 'forks',
                 :Commit      => 'commit',
                 :Commits     => 'commits',
                 :Download    => 'download',
                 :Webhooks    => 'webhooks',
                 :PullRequest => 'pull_request',
                 :DefaultReviewers => 'default_reviewers'

    DEFAULT_REPO_OPTIONS = {
        "website"         => "",
        "is_private"      => false,
        "has_issues"      => false,
        "has_wiki"        => false,
        "scm"             => "git",
        "no_public_forks" => false
    }.freeze

    VALID_REPO_OPTIONS = %w[
      owner
      name
      description
      website
      is_private
      has_issues
      has_wiki
      no_public_forks
      language
      scm
    ].freeze

    # Creates new Repositories API
    def initialize(options = { })
      super(options)
    end

    # Access to Repos::Commits API
    def changesets
      @changesets ||= ApiFactory.new 'Repos::Changesets'
    end

    # Access to Repos::Keys API
    def keys
      @keys ||= ApiFactory.new 'Repos::Keys'
    end

    # Access to Repos::Watchin API
    def following
      @following ||= ApiFactory.new 'Repos::Following'
    end

    # Access to Repos::Commits API
    def sources
      @sources ||= ApiFactory.new 'Repos::Sources'
    end

    # Access to Repos::Services API
    def services
      @services ||= ApiFactory.new 'Repos::Services'
    end
    def forks
      @forks ||= ApiFactory.new 'Repos::Forks'
    end
    def commit
      @commit ||=ApiFactory.new 'Repos::Commit'
    end
    def commits
      @commits ||=ApiFactory.new 'Repos::Commits'
    end
    def download
      @download ||=ApiFactory.new "Repos::Download"
    end

    # Access to Repos::PullRequests API
    def pull_request
      @pull_request ||= ApiFactory.new 'Repos::PullRequest'
    end

    def default_reviewers
      @default_reviewers ||= ApiFactory.new 'Repos::DefaultReviewers'
    end

    # List branches
    #
    # = Examples
    #
    #   bitbucket = BitBucket.new
    #   bibucket.repos.branches 'user-name', 'repo-name'
    #
    #   repos = BitBucket::Repos.new
    #   repos.branches 'user-name', 'repo-name'
    #
    def branches(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless (user? && repo?)
      normalize! params

      response = get_request("/1.0/repositories/#{user}/#{repo.downcase}/branches/", params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    alias :list_branches :branches

    # FIXME: 'POST a new repository' is a deprecated feature of the API
    # Create a new repository for the authenticated user.
    #
    # = Parameters
    #  <tt>:name</tt> - Required string
    #  <tt>:description</tt> - Optional string
    #  <tt>:website</tt> - Optional string
    #  <tt>:is_private</tt> - Optional boolean - <tt>true</tt> to create a private repository, <tt>false</tt> to create a public one.
    #  <tt>:has_issues</tt> - Optional boolean - <tt>true</tt> to enable issues for this repository, <tt>false</tt> to disable them
    #  <tt>:has_wiki</tt> - Optional boolean - <tt>true</tt> to enable the wiki for this repository, <tt>false</tt> to disable it. Default is <tt>true</tt>
    #  <tt>:owner</tt> Optional string - The team in which this repository will be created
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.create "name" => 'repo-name'
    #    "description": "This is your first repo",
    #    "website": "https://bitbucket.com",
    #    "is_private": false,
    #    "has_issues": true,
    #    "has_wiki": true
    #
    # Create a new repository in this team. The authenticated user
    # must be a member of this team
    #
    # Examples:
    #   bitbucket = BitBucket.new :oauth_token => '...', :oauth_secret => '...'
    #   bitbucket.repos.create :name => 'repo-name', :owner => 'team-name'
    #
    def create(*args)
      params = args.extract_options!
      normalize! params
      filter! VALID_REPO_OPTIONS + %w[ org ], params
      assert_required_keys(%w[ name ], params)

      # Requires authenticated user
      post_request("/1.0/repositories/", DEFAULT_REPO_OPTIONS.merge(params))
    end

    # Edit a repository
    #
    # = Parameters
    # * <tt>:name</tt> Required string
    # * <tt>:description</tt>   Optional string
    # * <tt>:website</tt>       Optional string
    # * <tt>:private</tt> - Optional boolean - <tt>false</tt> to create public reps, <tt>false</tt> to create a private one
    # * <tt>:has_issues</tt>    Optional boolean - <tt>true</tt> to enable issues for this repository, <tt>false</tt> to disable them
    # * <tt>:has_wiki</tt>      Optional boolean - <tt>true</tt> to enable the wiki for this repository, <tt>false</tt> to disable it. Default is <tt>true</tt>
    # * <tt>:has_downloads</tt> Optional boolean - <tt>true</tt> to enable downloads for this repository
    #
    # = Examples
    #
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.edit 'user-name', 'repo-name',
    #    :name => 'hello-world',
    #    :description => 'This is your first repo',
    #    :website => "https://bitbucket.com",
    #    :public => true, :has_issues => true
    #
    def edit(user_name, repo_name, params={ })
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?

      normalize! params
      filter! VALID_REPO_OPTIONS, params

      put_request("/1.0/repositories/#{user}/#{repo.downcase}/", DEFAULT_REPO_OPTIONS.merge(params))
    end

    # Get a repository
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.get 'user-name', 'repo-name'
    #
    def get(user_name, repo_name, params={ })
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      get_request("/1.0/repositories/#{user}/#{repo.downcase}", params)
    end

    alias :find :get

    # FIXME: 'DELETE an existing repository' is a deprecated feature of the API
    # Delete a repository
    #
    # = Examples
    #  @bitbucket = BitBucket.new
    #  @bitbucket.repos.delete 'user-name', 'repo-name'
    #
    def delete(user_name, repo_name)
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?

      delete_request("/1.0/repositories/#{user}/#{repo.downcase}")
    end

    # List repositories for the authenticated user
    #
    # = Examples
    #   bitbucket = BitBucket.new :oauth_token => '...', :oauth_secret => '...'
    #   bitbucket.repos.list
    #   bitbucket.repos.list { |repo| ... }
    #
    # List public repositories for the specified user.
    #
    # = Examples
    #   bitbucket = BitBucket.new
    #   bitbucket.repos.list :user => 'user-name'
    #   bitbucket.repos.list :user => 'user-name', { |repo| ... }
    def list(*args)
      params = args.extract_options!
      normalize! params
      _merge_user_into_params!(params) unless params.has_key?('user')
      filter! %w[ user type ], params

      response = #if (user_name = params.delete("user"))
                 #  get_request("/1.0/users/#{user_name}", params)
                 #else
                   # For authenticated user
                   get_request("/1.0/user/repositories", params)
                 #end
      return response unless block_given?
      response.each { |el| yield el }
    end

    alias :all :list

    # List tags
    #
    # = Examples
    #   bitbucket = BitBucket.new
    #   bitbucket.repos.tags 'user-name', 'repo-name'
    #   bitbucket.repos.tags 'user-name', 'repo-name' { |tag| ... }
    #
    def tags(user_name, repo_name, params={ })
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      response = get_request("/1.0/repositories/#{user}/#{repo.downcase}/tags/", params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    alias :list_tags :tags
    alias :repo_tags :tags
    alias :repository_tags :tags

  end # Repos
end # BitBucket
