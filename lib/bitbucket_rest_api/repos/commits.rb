# encoding: utf-8

module BitBucket
  class Repos::Commits < API

    VALID_KEY_PARAM_NAMES = %w(include exclude).freeze

    # Gets the commit information associated with a repository. By default, this
    # call returns all the commits across all branches, bookmarks, and tags. The
    # newest commit is first.
    #
    # = Parameters
    # *<tt>include</tt> - The SHA, branch, bookmark, or tag to include, for example, v10 or master. You can repeat the parameter multiple times.
    # *<tt>exclude</tt> - The SHA, branch, bookmark, or tag to exclude, for example, v10 or master . You can repeat the parameter multiple times.
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.commits.list 'user-name', 'repo-name'
    #  bitbucket.repos.commits.list 'user-name', 'repo-name', 'master'
    #  bitbucket.repos.commits.list 'user-name', 'repo-name' { |key| ... }
    #  bitbucket.repos.commits.list 'user-name', 'repo-name', nil,
    #    "include" => "feature-branch",
    #    "exclude" =>  "master"
    #
    def list(user_name, repo_name, branchortag=nil, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params
      filter! VALID_KEY_PARAM_NAMES, params

      path = "/2.0/repositories/#{user}/#{repo.downcase}/commits"
      path << "/#{branchortag}" if branchortag
      response = get_request(path, params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

  end # Repos::Commits
end # BitBucket
