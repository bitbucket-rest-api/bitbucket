# encoding: utf-8
module BitBucket
  class Repos::Commit < API
    # Gets the commit information associated with a repository.
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.commit.list 'user-name', 'repo-name', hash,
    #
    def list(user_name, repo_name, hash)
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?

      path = "/2.0/repositories/#{user}/#{repo.downcase}/commit/#{hash}"
      response = get_request(path)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list
  end # Repos::Commit
end # BitBucket
