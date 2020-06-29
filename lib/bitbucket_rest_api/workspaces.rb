# encoding: utf-8

module BitBucket
  class Workspaces < API
    extend AutoloadHelper

    # Load all the modules after initializing Repos to avoid superclass mismatch
    autoload_all 'bitbucket_rest_api/workspaces',
                 :Members       => 'members'

    # Creates new Workspaces API
    def initialize(options = { })
      super(options)
    end

    # List workspaces for the authenticated user
    #
    # = Examples
    #   bitbucket = BitBucket.new :oauth_token => '...', :oauth_secret => '...'
    #   bitbucket.workspaces.list
    #   bitbucket.workspaces.list { |workspace| ... }
    def list(*args)
      params = args.extract_options!
      normalize! params
      _merge_user_into_params!(params)
      params.merge!('pagelen' => 100) unless params.has_key?('pagelen')
      
      filter! %w[ pagelen ], params

      response = get_request("/2.0/workspaces", params)

      response = response[:values]
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    def permissions(workspace_slug)
      get_request("/2.0/workspaces/#{workspace_slug}/permissions")
    end

    # Access to Workspaces::Members API
    def members
      @members ||= ApiFactory.new 'Workspaces::Members'
    end
  end # Workspaces
end # BitBucket
