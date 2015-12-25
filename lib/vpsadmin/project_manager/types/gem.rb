module VpsAdmin::ProjectManager
  module Types
    class Gem < Project
      def version
        project_dir do
          f = Dir.glob('lib/**/version.rb').first
          next unless f

          /VERSION\s*=\s*'([^']+)'/.match(File.read(f))[1]
        end
      end
    end
  end
end
