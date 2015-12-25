module VpsAdmin
  module ProjectManager ; end
end

require_relative 'project_manager/project'
require_relative 'project_manager/project_env'
require_relative 'project_manager/types/gem'
require_relative 'project_manager/cli'
require_relative 'project_manager/version'

def project(*args, &block)
  VpsAdmin::ProjectManager.register(*args, &block)
end

module VpsAdmin
  module ProjectManager
    PROJECT_TYPES = {
        gem: Types::Gem,
    }

    def self.projects
      @projects
    end
    
    def self.load
      @projects = []

      path = File.join(
          File.dirname(__FILE__),
          '..', '..',
          'projects'
      )

      Dir.glob(File.join(path, '*.rb')).each do |f|
        @current_name = File.basename(f).split('.')[0..-2].join('.')
        Kernel.load(f)
      end
    end

    def self.register(*args, &block)
      @projects ||= []
      
      env = ProjectEnv.new
      env.instance_exec(&block)
      
      args.insert(0, @current_name)
      args.insert(1, env)

      @projects << if PROJECT_TYPES[env.type]
                     PROJECT_TYPES[env.type].new(*args)
                  else
                    Project.new(*args)
                  end
    end

    load
  end
end
