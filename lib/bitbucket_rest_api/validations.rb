# encoding: utf-8

module BitBucket
  module Validations
    extend AutoloadHelper

    autoload_all 'bitbucket_rest_api/validations',
                 :Presence => 'presence',
                 :Token    => 'token',
                 :Format   => 'format',
                 :Required => 'required'

    include Presence
    include Format
    include Token
    include Required

    VALID_API_KEYS = [
        'page',
        'per_page',
        'jsonp_callback'
    ]

  end # Validation
end # BitBucket
