
# Gem::Specification for Merb_strokedb-1
# Originally generated by Echoe

Gem::Specification.new do |s|
  s.name = %q{merb_strokedb}
  s.version = "1"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["elliottcable"]
  s.date = %q{2008-04-29}
  s.description = %q{a plugin for Merb, that allows the use of StrokeDB as an ORM within a Merb application}
  s.email = ["merb_strokedb@elliottcable.com"]
  s.extra_rdoc_files = ["lib/merb/orms/strokedb/connection.rb", "lib/merb/orms/strokedb/store.example.yml", "lib/merb_strokedb/strokedb.task", "lib/merb_strokedb.rb", "README.mkdn"]
  s.files = ["example_merb_app/application.rb", "example_merb_app/config/framework.rb", "example_merb_app/config/init.rb", "example_merb_app/config/store.yml", "example_merb_app/views/test.html.haml", "lib/merb/orms/strokedb/connection.rb", "lib/merb/orms/strokedb/store.example.yml", "lib/merb_strokedb/strokedb.task", "lib/merb_strokedb.rb", "README.mkdn", "task/echoe.task", ".manifest", "merb_strokedb.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://find.elliottcable.name/merb_strokedb}
  s.post_install_message = %q{ - Thanks for installing merb_strokedb!
 - Add this to your config/init.rb to get started:
 -   use_orm :strokedb}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Merb_strokedb", "--main", "README.mkdn"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{merb-strokedb}
  s.rubygems_version = %q{1.1.1}
  s.summary = %q{StrokeDB plugin for Merb}

  s.add_dependency(%q<merb-core>, [">= 0"])
  s.add_dependency(%q<strokedb>, [">= 0"])
end


# # Original Rakefile source (requires the Echoe gem):
# 
# require 'rubygems'; require 'merb-core'
# $:.unshift(File.dirname(__FILE__) + '/lib'); require 'merb_strokedb'
# Dir['task/**/*.task'].each {|t| load t}
# require 'fileutils'; include FileUtils
# 
# Echoe.taskify do
#   Echoe.new('merb_strokedb', Merb::Orms::StrokeDB::VERSION) do |g|
#     g.author = ['elliottcable']
#     g.email = ['merb_strokedb@elliottcable.com']
#     g.summary = 'StrokeDB plugin for Merb'
#     g.url = 'http://find.elliottcable.name/merb_strokedb'
#     g.description = 'a plugin for Merb, that allows the use of StrokeDB as an ORM within a Merb application'
#     g.dependencies = ['merb-core', 'strokedb']
#     g.manifest_name = '.manifest'
#     g.ignore_pattern = /(^\.git|^example_merb_app\/(db|log))/
#     g.project = 'merb-strokedb'
#     g.install_message = " - Thanks for installing merb_strokedb!\n" +
#                         " - Add this to your config/init.rb to get started:\n"+
#                         " -   use_orm :strokedb"
#   end
#   
#   desc 'tests packaged files to ensure they are all present'
#   task :verify => :package do
#     # An error message will be displayed if files are missing
#     if system %(ruby -e "require 'rubygems'; require 'merb-core'; require 'pkg/merb_strokedb-#{Merb::Orms::StrokeDB::VERSION}/lib/merb_strokedb'")
#       puts "\nThe library files are present"
#     end
#   end
#   
#   task :copy_gemspec => [:package] do
#     pkg = Dir['pkg/*'].select {|dir| File.directory? dir}.last
#     mv File.join(pkg, pkg.gsub(/^pkg\//,'').gsub(/\-\d+$/,'.gemspec')), './'
#   end
#   
#   desc 'builds a gemspec as GitHub wants it'
#   task :gemspec => [:package, :copy_gemspec, :clobber_package]
#   
#   # desc 'Run specs, clean tree, update manifest, run coverage, and install gem!'
#   desc 'Clean tree, update manifest, and install gem!'
#   task :magic => [:clean, :manifest, :install]
# end