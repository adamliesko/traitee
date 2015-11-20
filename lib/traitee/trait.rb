require 'forwardable'
require 'traitee/merger'
require 'traitee/dict'

module Traitee
  module Trait
    extend Forwardable # we want some delegators in here, to delegate to the included trait
    def_instance_delegators :this, :instance_methods, :send
    alias_method :[], :methods

    include Merger

    def this
      @this ||= Module.new
    end

    def dict
      @dict ||= Dict.new
    end

    # usable methods
    def methods(options = {})
      served_from(this, *this.instance_methods)
      dict.methods_hash(options)
    end

    # helper for actual method definitions
    def serves(&method_def)
      this.module_eval(&method_def)
    end

    # store Module where method is defined (trait) and actual method name
    def served_from(trait_module, *methods)
      methods.each { |method_name| dict << [trait_module, method_name] }
    end

    def self.subject_composition(*params, &block)
      Class.new do
        extend Trait
        merge(*params) unless params.empty?
        serves(&block) if block
      end
    end
  end
end
