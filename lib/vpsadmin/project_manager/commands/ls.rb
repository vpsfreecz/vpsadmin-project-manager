module VpsAdmin::ProjectManager
  class Commands::Ls < Cli
    def execute
      VpsAdmin::ProjectManager.projects.each do |p|
        puts p.name
      end
    end
  end
end
