task :compile do
  exec("coffee -o output -cw *.coffee")
end

task :default => :compile

task :setup do
  system "brew install coffee-script"
end

task :clean do
  rm_rf "output"
end
