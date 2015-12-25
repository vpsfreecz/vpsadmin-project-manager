module VpsAdmin::ProjectManager
  class ProjectEnv
    %i(type version).each do |attr|
      define_method(attr) do |v = nil, &block|
        if v && block
          fail 'provide either an argument or block'

        elsif v
          instance_variable_set("@#{attr}", v)

        elsif block
          instance_variable_set("@#{attr}", block)

        else
          instance_variable_get("@#{attr}")
        end
      end
    end
  end
end
