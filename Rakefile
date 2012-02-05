desc 'compile all coffee files in the root directory to the output directory and continue to watch'
task :compile do
  system %(coffee -o output -cwj all.js src/*.coffee src/components/*.coffee)
end

task :default => :compile

desc 'install coffee-script with brew (Mac OS X)'
task :setup do
  system "brew install coffee-script"
end

desc 'clean out the output directory'
task :clean do
  rm_rf "output"
end
