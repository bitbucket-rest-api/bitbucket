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
      @oauth ||= ApiFactory.new 'Request::OAuth', options
    end
    alias :authorizations :oauth

    def teams(options = {})
      @teams ||= ApiFactory.new 'Teams', options
    end

    def pull_requests(options = {})
      @pull_requests ||= ApiFactory.new 'Repos::PullRequest', options
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
      @users ||= ApiFactory.new 'Users', options
    end

    def user_api(options = {})
      @user_api ||= ApiFactory.new 'User', options
    end

    def invitations(options = {})
      @invitations ||= ApiFactory.new "Invitations", options
    end
  end # Client
end # BitBucket
