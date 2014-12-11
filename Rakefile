task :default => :run

desc "run xripper "
task :run do
  sh "ruby -I. xripper sample.xr fellowship.xml"
end

desc "run xripper for a script with errors"
task :run do
  sh "ruby -I. xripper sample_err.xr fellowship.xml"
end
