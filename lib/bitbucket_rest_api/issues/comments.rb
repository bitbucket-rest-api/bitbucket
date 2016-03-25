# encoding: utf-8

module BitBucket
  class Issues::Comments < API

    VALID_ISSUE_COMMENT_PARAM_NAME = %w[
      content
    ].freeze

    # Creates new Issues::Comments API
    def initialize(options = {})
      super(options)
    end

    # List comments on an issue
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.issues.comments.all 'user-name', 'repo-name', 'issue-id'
    #  bitbucket.issues.comments.all 'user-name', 'repo-name', 'issue-id' {|com| .. }
    #
    def list(user_name, repo_name, issue_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of issue_id

      normalize! params
      # _merge_mime_type(:issue_comment, params)

      response = get_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/#{issue_id}/comments/", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Get a single comment
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.issues.comments.find 'user-name', 'repo-name', 'comment-id'
    #
    def get(user_name, repo_name, comment_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of comment_id

      normalize! params
      # _merge_mime_type(:issue_comment, params)

      get_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/comments/#{comment_id}", params)
    end
    alias :find :get

    # Create a comment
    #
    # = Inputs
    #  <tt>:content</tt> Required string
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.issues.comments.create 'user-name', 'repo-name', 'issue-id',
    #     "content" => 'a new comment'
    #
    def create(user_name, repo_name, issue_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of issue_id

      normalize! params
      # _merge_mime_type(:issue_comment, params)
      filter! VALID_ISSUE_COMMENT_PARAM_NAME, params
      assert_required_keys(%w[ content ], params)

      post_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/#{issue_id}/comments/", params)
    end

    # Edit a comment
    #
    # = Inputs
    #  <tt>:content</tt> Required string
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.issues.comments.edit 'user-name', 'repo-name', 'comment-id',
    #     "content" => 'a new comment'
    #
    def edit(user_name, repo_name, comment_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of comment_id

      normalize! params
      # _merge_mime_type(:issue_comment, params)
      filter! VALID_ISSUE_COMMENT_PARAM_NAME, params
      assert_required_keys(%w[ content ], params)

      put_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/comments/#{comment_id}", params)
    end

    # Delete a comment
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.issues.comments.delete 'user-name', 'repo-name', 'comment-id'
    #
    def delete(user_name, repo_name, comment_id, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of comment_id

      normalize! params
      # _merge_mime_type(:issue_comment, params)

      delete_request("/1.0/repositories/#{user}/#{repo.downcase}/issues/comments/#{comment_id}", params)
    end

  end # Issues::Comments
end # BitBucket
