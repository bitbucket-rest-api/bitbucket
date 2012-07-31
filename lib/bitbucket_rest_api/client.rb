# encoding: utf-8

module BitBucket
  class Client < API

    # This is a read-only API to the BitBucket events.
    # These events power the various activity streams on the site.
    def events(options = {})
      raise "Unimplemented"
      #@events ||= ApiFactory.new 'Events', options
    end

    def issues(options = {})
      @issues ||= ApiFactory.new 'Issues', options
    end

    # An API for users to manage their own tokens.
    def oauth(options = {})
      raise "Unimpletmented"
      #@oauth ||= ApiFactory.new 'Authorizations', options
    end
    alias :authorizations :oauth

    def teams(options = {})
      raise "Unimplemented"
      #@teams ||= ApiFactory.new 'teams', options
    end

    def pull_requests(options = {})
      raise "Unimplemented"
      #@pull_requests ||= ApiFactory.new 'PullRequests', options
    end

    def repos(options = {})
      @repos ||= ApiFactory.new 'Repos', options
    end
    alias :repositories :repos

    def search(options = {})
      raise "Unimplemented"
      #@search ||= ApiFactory.new 'Search', options
    end

    # Many of the resources on the users API provide a shortcut for getting
    # information about the currently authenticated user.
    def users(options = {})
      raise "Unimplemented"
      #@users ||= ApiFactory.new 'Users', options
    end

  end # Client
end # BitBucket