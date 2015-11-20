require 'set'

module Traitee
  class Dict
    def initialize
      @methods = Set.new
    end

    def <<(method)
      @methods << method
    end

    def methods_hash(options = {})
      except = Array(options[:except])
      aliases = options.fetch :aliases, {}

      methods_hash = Hash[
        @methods.map { |method| traitee_module, name = method; [name, traitee_module.instance_method(name)] }
      ]
      methods_hash = exclusions(methods_hash, except)
      aliases(methods_hash, aliases)
    end

    # fetch only methods on included in except opts
    def exclusions(methods, exclusions)
      methods.select { |method_name, _| !exclusions.include?(method_name) }
    end

    # create aliases for selected methods as described in  opts
    def aliases(methods, aliases)
      Hash[methods.map { |method_name, _method| [(aliases.include?(method_name) ? aliases[method_name] : method_name), _method] }]
    end
  end
end
