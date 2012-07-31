# encoding: utf-8

require 'faraday'
require 'bitbucket_rest_api/error'

module BitBucket
  class Response::RaiseError < Faraday::Response::Middleware

    def on_complete(env)
      case env[:status].to_i
      when 400
        raise BitBucket::Error::BadRequest.new(env)
      when 401
        raise BitBucket::Error::Unauthorized.new(env)
      when 403
        raise BitBucket::Error::Forbidden.new(env)
      when 404
        raise BitBucket::Error::NotFound.new(env)
      when 422
        raise BitBucket::Error::UnprocessableEntity.new(env)
      when 500
        raise BitBucket::Error::InternalServerError.new(env)
      when 503
        raise BitBucket::Error::ServiceUnavailable.new(env)
      when 400...600
        raise BitBucket::Error::ServiceError.new(env)
      end
    end

  end # Response::RaiseError
end # BitBucket
