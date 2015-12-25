require 'clamp'

module VpsAdmin
  module ProjectManager
    module Commands ; end

    class Cli < Clamp::Command ; end
    
    Dir[File.join(
        File.dirname(__FILE__),
        'commands',
        '*.rb'
    )].each {|file| require file }

    class Cli
      subcommand 'status', "Show projects' status", Commands::Status
    end
  end
end
