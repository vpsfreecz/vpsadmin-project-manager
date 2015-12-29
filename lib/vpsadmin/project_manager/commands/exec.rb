module VpsAdmin::ProjectManager
  class Commands::Exec < Cli
    parameter 'COMMAND', 'command to execute'

    def execute
      VpsAdmin::ProjectManager.projects.each do |p|
        puts "* #{p.label}"
        
        p.send(:project_dir) do
          puts `#{command}`
        end

        puts
      end
    end
  end
end
