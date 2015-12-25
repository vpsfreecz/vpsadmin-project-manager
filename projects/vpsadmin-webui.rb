project 'vpsAdmin WebUI' do
  VERSION_FILE = 'lib/version.lib.php'
  VERSION_RX = /define\s*\(\s*"VERSION"\s*,\s*'([^']+)'\s*\)\s*;/

  type :custom
  version do
    VERSION_RX.match(File.read(VERSION_FILE))[1]
  end

  set_version do |v|
    File.write(
      VERSION_FILE,
      File.read(VERSION_FILE).sub!(VERSION_RX, "define(\"VERSION\", '#{v}');")
    )
  end
end
