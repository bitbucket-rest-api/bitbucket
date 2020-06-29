# encoding: utf-8

module BitBucket
  class Repos::BranchRestrictions < API

    VALID_KEY_PARAM_NAMES = %w(kind pattern).freeze

    # Gets the branch_restrictions information associated with a repository.
    #
    # = Parameters
    # *<tt>kind</tt> - Branch restrictions of this type
    # *<tt>pattern</tt> - Branch restrictions applied to branches of this pattern
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.branch_restrictions.list 'user-name', 'repo-name'
    #  bitbucket.repos.branch_restrictions.list 'user-name', 'repo-name', 'master'
    #  bitbucket.repos.branch_restrictions.list 'user-name', 'repo-name' { |key| ... }
    #  bitbucket.repos.branch_restrictions.list 'user-name', 'repo-name', nil,
    #    "kind" => "...",
    #    "pattern" =>  "..."
    #
    def list(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params
      filter! VALID_KEY_PARAM_NAMES, params

      path = "/2.0/repositories/#{user}/#{repo.downcase}/branch-restrictions"
      response = get_request(path, params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

  end # Repos::BranchRestrictions
end # BitBucket
