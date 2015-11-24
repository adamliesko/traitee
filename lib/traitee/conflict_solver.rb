module Traitee
  class MethodsInConflict < StandardError
  end

  class ConflictSolver
    attr_reader :conflicting_methods

    def initialize(methods)
      @methods = methods
      @conflicting_methods = {}
    end

    # java reference :P, actual resolved module holder
    def this
      @this ||= Module.new
    end

    def conflictless_method_map
      @methods.reduce({}) do |res, map|
        res.merge!(map) { |method_name, method_a, method_b| solve_possible_conflict(method_name, method_a, method_b) }
      end
    end

    # let it build, actual error will be raised later on all the usages of the method
    def solve_possible_conflict(method_name, method_a, method_b)
      method_a == method_b ? method_a : method_in_conflict(method_name, method_a, method_b)
    end

    def method_in_conflict(method_name, method_a, method_b)
      conflict_solver = self
      @conflicting_methods[method_name] = [method_a, method_b]

      # define a method which raises an error - uncallable
      this.send(:define_method, method_name) do
        _method_a, _method_b = conflict_solver.conflicting_methods[method_name]
        fail MethodsInConflict.new "Modules  are in conflict with method :#{method_name}"
      end

      this.instance_method(method_name)
    end
  end
end