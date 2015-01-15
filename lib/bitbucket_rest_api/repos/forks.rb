# encoding: utf-8

module BitBucket
  class Repos::Forks < API

    REQUIRED_KEY_PARAM_NAMES = %w[ name ].freeze
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


    # Create a fork
    #
    # = Inputs
    # * <tt>:type</tt> - One of the supported services. The type is a case-insensitive value.
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.forks.create 'user-name', 'repo-name',
    #    "name"           => "Basecamp",
    #
    def create(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params
      assert_required_keys(REQUIRED_KEY_PARAM_NAMES, params)
      filter! VALID_REPO_OPTIONS, params

      post_request("/repositories/#{user}/#{repo.downcase}/fork", params)
    end


  end # Repos::Keys
end # BitBucket
