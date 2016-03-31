# encoding: utf-8

module BitBucket
  class Team < API
    extend AutoloadHelper

    def initialize(options = { })
      super(options)
    end

    def list(user_role)
      response = get_request("/2.0/teams/?role=#{user_role.to_s}")
      return response unless block_given?
      response.each { |el| yield el }
    end


  end # Users
end # BitBucket
