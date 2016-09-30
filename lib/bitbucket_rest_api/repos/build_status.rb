# encoding: utf-8
# frozen_string_literal: true
module BitBucket
  class Repos::BuildStatus < API
    CREATE_OPTIONS = {
      headers: {
        'Content-Type' => 'application/json'
      }
    }.freeze

    def create(user_name, repo_name, sha1, status)
      post_request(
        EndpointBuilder.build(user_name, repo_name, sha1),
        status.to_h,
        CREATE_OPTIONS
      )
    end

    class Status < Struct.new(:url, :description, :state)
      def initialize(**kwargs)
        kwargs.each { |key, val| public_send(:"#{key}=", val) }
      end

      module State
        SUCCESSFUL = 'SUCCESSFUL'.freeze
        FAILED     = 'FAILED'.freeze
        INPROGRESS = 'INPROGRESS'.freeze
        STOPPED    = 'STOPPED'.freeze
      end # module State
    end # module Status

    class EndpointBuilder
      ENDPOINT =
        '/2.0/repositories/%{user}/%{repo}/commit/%{sha1}/statuses/build'.freeze

      def self.build(user_name, repo_name, commit_hash)
        new(user_name, repo_name, commit_hash).endpoint
      end

      def endpoint
        ENDPOINT % url_params
      end

      private

      def initialize(user_name, repo_name, commit_hash)
        @user_name   = user_name
        @repo_name   = repo_name
        @commit_hash = commit_hash
      end

      def url_params
        {
          user: @user_name,
          repo: @repo_name,
          sha1: @commit_hash
        }
      end
    end # class Creator
  end # class Repos::BuildStatus
end # module BitBucket
