# encoding: utf-8

module BitBucket
  class API

    # Returns all API public methods for a given class.
    def self.inherited(klass)
      klass.class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        def self.actions
          self.new.api_methods_in(#{klass})
        end
        def actions
          api_methods_in(#{klass})
        end
      RUBY_EVAL
      super
    end

    def api_methods_in(klass)
      methods = []
      (klass.send(:instance_methods, false) - ['actions']).sort.each do |method|
        methods << method
      end
      klass.included_modules.each do |mod|
        if mod.to_s =~ /#{klass}/
          mod.instance_methods(false).each do |met|
            methods << met
          end
        end
      end
      methods
    end

  end # API
end # BitBucket
