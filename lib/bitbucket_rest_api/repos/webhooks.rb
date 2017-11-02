module BitBucket
  class Repos::Webhooks < API
    EVENTS =  [
      'repo:push',
      'repo:fork',
      'repo:commit_comment_created',
      'repo:commit_status_created',
      'repo:commit_status_updated',
      'issue:created',
      'issue:updated',
      'issue:comment_created',
      'pullrequest:created',
      'pullrequest:updated',
      'pullrequest:approved',
      'pullrequest:unapproved',
      'pullrequest:fulfilled',
      'pullrequest:rejected',
      'pullrequest:comment_created',
      'pullrequest:comment_updated',
      'pullrequest:comment_deleted',
      # server events
      'repo:refs_changed'
    ]

    def create(user_name, repo_name, params = {})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params
      assert_required_keys(%w[description url active events], params)
      _validate_given_events(params)
      assert_required_values_present(
        params,
        'description',
        'url',
        'active',
        'events'
      )


      options = { headers: { "Content-Type" => "application/json" } }
      url = if BitBucket.options[:bitbucket_server]
              "/1.0/users/#{user_name}/repos/#{repo_name}/webhooks"
            else
              "/2.0/repositories/#{user_name}/#{repo_name}/hooks"
            end
      post_request(url, params, options)
    end

    def list(user_name, repo_name)
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?

      url = if BitBucket.options[:bitbucket_server]
              "/1.0/users/#{user_name}/repos/#{repo_name}/webhooks"
            else
              "/2.0/repositories/#{user_name}/#{repo_name}/hooks"
            end

      get_request(url)
    end

    def get(user_name, repo_name, hook_uuid)
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?

      get_request(
        "/2.0/repositories/#{user_name}/#{repo_name}/hooks/#{hook_uuid}"
      )
    end

    def edit(user_name, repo_name, hook_uuid, params = {})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params
      assert_required_keys(%w[description url active events], params)
      _validate_given_events(params)
      assert_required_values_present(
        params,
        'description',
        'url',
        'active',
        'events'
      )


      options = { headers: { "Content-Type" => "application/json" } }
      put_request(
        "/2.0/repositories/#{user_name}/#{repo_name}/hooks/#{hook_uuid}",
        params, options)
    end

    def delete(user_name, repo_name, hook_uuid)
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?

      url = if BitBucket.options[:bitbucket_server]
              "/1.0/users/#{user_name}/repos/#{repo_name}/webhooks/#{hook_uuid}"
            else
              "/2.0/repositories/#{user_name}/#{repo_name}/hooks/#{hook_uuid}"
            end

      delete_request(url)
    end

    private
    def _validate_given_events(params)
      given_events = params['events']
      raise BitBucket::Error::NoEvents if given_events.empty?
      given_events.each do |k|
        unless EVENTS.include?(k)
          raise BitBucket::Error::BadEvents, k
        end
      end
    end
  end
end
