module VpsAdmin
  module ProjectManager
    class Project
      def initialize(name, env, label = nil, &block)
        @name = name
        @label = label
        @env = env
        @cache = {}
      end

      def label
        @label || @name
      end

      def branch
        cached(:branch) do
          exec("git branch | grep '*'").strip[2..-1]
        end
      end

      def version
        cached(:version) do
          if @env.version.is_a?(::Proc)
            v = project_dir do
              @env.version.call
            end

            return v === true ? 'n/a' : v

          else
            'not set'
          end
        end
      end

      protected
      def exec(cmd)
        project_dir { `#{cmd}` }
      end

      def project_dir
        d = Dir.pwd
        Dir.chdir(File.join(d, @name))
        ret = yield
        Dir.chdir(d)
        ret
      end

      def cached(name)
        return @cache[name] if @cache.has_key?(name)
        @cache[name] = yield
      end
    end
  end
end
