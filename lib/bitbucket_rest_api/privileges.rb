# encoding: utf-8

module BitBucket
  class Privileges < API
    VALID_KEY_PARAM_NAMES = %w(filter).freeze

    # Creates new Privileges API
    def initialize(options = {})
      super(options)
    end

    # Gets a list of the privileges granted on a repository.
    #
    # = Parameters
    # *<tt>filter</tt> - Filters for a particular privilege. The acceptable values are:<tt>read</tt>, <tt>write</tt> and <tt>admin</tt>.
    #
    # = Examples
    # bitbucket = BitBucket.new
    # bitbucket.privileges.list 'user-name', 'repo-name', :filter => "admin"
    #
    def list_on_repo(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?

      normalize! params
      filter! VALID_KEY_PARAM_NAMES, params

      response = get_request("/1.0/privileges/#{user}/#{repo.downcase}/", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all_on_repo :list_on_repo

    # Gets a list of all the privilege across all an account's repositories.
    #
    # = Parameters
    # *<tt>filter</tt> - Filters for a particular privilege. The acceptable values are:<tt>read</tt>, <tt>write</tt> and <tt>admin</tt>.
    #
    # = Examples
    # bitbucket = BitBucket.new
    # bitbucket.privileges.list 'user-name', :filter => "admin"
    #
    def list(user_name, params={})
      _update_user_repo_params(user_name)
      _validate_presence_of user_name

      normalize! params
      filter! VALID_KEY_PARAM_NAMES, params

      response = get_request("/1.0/privileges/#{user}/", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list
  end # Privileges
end # BitBucket
