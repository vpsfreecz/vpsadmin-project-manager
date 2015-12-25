project 'vpsAdmin WebUI' do
  type :custom
  version do
    rx = /define\s*\(\s*"VERSION"\s*,\s*'([^']+)'\s*\)\s*;/
    rx.match(File.read('lib/version.lib.php'))[1]
  end
end
