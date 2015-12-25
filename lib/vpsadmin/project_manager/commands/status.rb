module VpsAdmin::ProjectManager
  class Commands::Status < Cli
    def execute
      puts sprintf(
          '%-30s %-20s %10s',
          'PROJECT', 'BRANCH', 'VERSION'
      )

      VpsAdmin::ProjectManager.projects.each do |p|
        puts sprintf(
            '%-30s %-20s %10s',
            p.label, p.branch, p.version
        )
      end
    end
  end
end
