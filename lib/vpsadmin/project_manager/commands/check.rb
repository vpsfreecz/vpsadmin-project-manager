module VpsAdmin::ProjectManager
  class Commands::Check < Cli
    parameter 'VERSION', 'version to check'

    def execute
      VpsAdmin::ProjectManager.projects.each do |p|
        puts "* #{p.label}"

        p.project_dir do
          %i(version changelog license).each do |v|
            @proj = p
            ret = send("check_#{v}")

            if ret.is_a?(::String)
              str = ret.empty? ? 'ok' : ret

            else
              str = ret ? 'ok' : 'error'
            end

            puts sprintf('  %15s ... %s', v, str)
          end
        end
      end
    end

    protected
    def check_version
      if @proj.version?
        version == @proj.version

      else
        'n/a'
      end

    rescue => e
      "failed (#{e.message})"
    end

    def check_license
      return 'not found' unless File.exists?('LICENSE')
      return 'empty' if File.zero?('LICENSE')
      true
    end

    def check_changelog
      return 'not found' unless File.exists?('CHANGELOG')

      log = File.read('CHANGELOG')
      return 'not mentioned' unless /\s\-\sversion\s#{version.gsub(/\./, '\.')}/ =~ log
      true
    end
  end
end
