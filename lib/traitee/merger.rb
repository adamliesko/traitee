require 'traitee/conflict_solver'

module Traitee
  module Merger

    #just check for conflicts, if there are any, we will raise an Error on call. Dont overwrite owners methods
    def merge(*maps)
      maps.map! { |map| Hash === map ? map : map.methods }
      conflictless_map = ConflictSolver.new(maps).conflictless_method_map
      conflictless_map.each do |method_name, method|
        # do not run check for included super methods
        send(:define_method, method_name, method) unless instance_methods(false).include?(method_name)
      end
    end
  end
end
