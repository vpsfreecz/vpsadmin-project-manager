module VpsAdmin::ProjectManager
  module Types
    class Gem < Project
      def version
        project_dir do
          f = version_file
          next unless f

          /VERSION\s*=\s*'([^']+)'/.match(File.read(f))[1]
        end
      end

      def version=(v)
        project_dir do
          f = version_file
          unless f
            raise RuntimeError, 'version.rb does not exist'
          end

          File.write(
              f,
              File.read(f).sub!(/VERSION\s*=\s*'([^']+)'/, "VERSION = '#{v}'")
          )
        end
      end

      def commit_version(msg)
        project_dir do
          exec("git commit -m \"#{msg}\" #{version_file}")
        end
      end

      protected
      def version_file
        Dir.glob('lib/**/version.rb').first
      end
    end
  end
end
