# encoding: utf-8

module BitBucket
  # Defines HTTP verbs
  module Request

    METHODS = [:get, :post, :put, :delete, :patch]
    METHODS_WITH_BODIES = [ :post, :put, :patch ]

    def get_request(path, params={}, options={})
      request(:get, path, params, options)
    end


    def patch_request(path, params={}, options={})
      request(:patch, path, params, options)
    end

    def post_request(path, params={}, options={})
      request(:post, path, params, options)
    end

    def put_request(path, params={}, options={})
      request(:put, path, params, options)
    end

    def delete_request(path, params={}, options={})
      request(:delete, path, params, options)
    end

    def request(method, path, params, options={})
      if !METHODS.include?(method)
        raise ArgumentError, "unkown http method: #{method}"
      end
      # _extract_mime_type(params, options)

      puts "EXECUTED: #{method} - #{path} with #{params} and #{options}" if ENV['DEBUG']

      conn = connection(options)
      path = (conn.path_prefix + path).gsub(/\/\//,'/') if conn.path_prefix != '/'

      response = conn.send(method) do |request|
        request['Authorization'] = "Bearer #{new_access_token}" unless new_access_token.nil?
        case method.to_sym
        when *(METHODS - METHODS_WITH_BODIES)
          request.body = params.delete('data') if params.has_key?('data')
          request.url(path, params)
        when *METHODS_WITH_BODIES
          request.path = path
          unless params.empty?
            # data = extract_data_from_params(params)
            # request.body = MultiJson.dump(data)
            request.body = MultiJson.dump(params)
          end
        end
      end
      response.body
    end

    private

    # def extract_data_from_params(params) # :nodoc:
    #   if params.has_key?('data') and !params['data'].nil?
    #     params['data']
    #   else
    #     params
    #   end
    # end

    def _extract_mime_type(params, options) # :nodoc:
      options['resource']  = params['resource'] ? params.delete('resource') : ''
      options['mime_type'] = params['resource'] ? params.delete('mime_type') : ''
    end

  end # Request
end # BitBucket
