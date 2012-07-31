# encoding: utf-8

require 'faraday'

module BitBucket
  class Response::Helpers < Response

    def on_complete(env)
      env[:body].class.class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        include BitBucket::Result

        def env
          @env
        end

      RUBY_EVAL
      env[:body].instance_eval { @env = env }
    end

  end # Response::Helpers
end # BitBucket
