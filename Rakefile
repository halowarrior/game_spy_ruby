require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'ffi-compiler/compile_task'
require 'rake'

task :default => [ :compile_ffi, :spec]

desc "clean, make and run specs"
task :spec  do
  RSpec::Core::RakeTask.new
end

desc "FFI compiler"
namespace "ffi-compiler" do
  FFI::Compiler::CompileTask.new('/Users/adam/workspace/game_spy_ruby/ext/game_spy') do |ct|
    ct.add_define("_MACOSX")
    ct.add_define("_NO_NOPORT_H_")
  end
end
task :compile_ffi => ["ffi-compiler:default"]

# namespace :gamespy do
#   task :compile do
#     FFI::Compiler::CompileTask.new('/Users/adam/workspace/game_spy_ruby/ext/game_spy') do |ct|
#       ct.add_define("_MACOSX")
#       ct.add_define("_NO_NOPORT_H_")
#     end
#   end
# end