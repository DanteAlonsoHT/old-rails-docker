module ActiveSupport
  module CoreExtensions
    module Module
      module QualifiedConst
        def qualified_const_defined?(path)
          path.split('::').inject(Object) do |mod, name|
            if mod.const_defined?(name, false)
              mod.const_get(name)
            else
              begin
                mod.const_get(name)
              rescue NameError
                return false
              end
            end
          end
        end
      end
    end
  end
end
