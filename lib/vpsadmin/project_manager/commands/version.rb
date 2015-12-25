module VpsAdmin::ProjectManager
  class Commands::Version < Cli
    option '--[no-]commit', :flag, 'commit version change in git'
    option ['-m', '--message'], 'MSG', 'commit message', attribute_name: :msg
    parameter 'VERSION', 'version to set'
    
    def execute
      puts sprintf(
          '%-30s %10s %10s',
          'PROJECT', 'OLD', 'NEW'
      )

      VpsAdmin::ProjectManager.projects.each do |p|
        old_v = p.version
        p.version = version
        new_v = p.version

        puts sprintf(
          '%-30s %10s %10s',
          p.label, old_v, new_v
        )

        p.commit_version(msg || "Bump version to v#{version}") if commit?
      end
    end
  end
end
