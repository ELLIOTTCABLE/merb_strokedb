require 'rubygems'; require 'merb-core'
$:.unshift(File.dirname(__FILE__) + '/lib'); require 'merb_strokedb'
Dir['task/**/*.task'].each {|t| load t}
require 'fileutils'; include FileUtils

Echoe.taskify do
  Echoe.new('merb_strokedb', Merb::Orms::StrokeDB::VERSION) do |g|
    g.author = ['elliottcable']
    g.email = ['merb_strokedb@elliottcable.com']
    g.summary = 'StrokeDB plugin for Merb'
    g.url = 'http://find.elliottcable.name/merb_strokedb'
    g.description = 'a plugin for Merb, that allows the use of StrokeDB as an ORM within a Merb application'
    g.dependencies = ['merb-core', 'strokedb']
    g.manifest_name = '.manifest'
    g.ignore_pattern = /(^\.git|^example_merb_app\/(db|log))/
    g.project = 'merb-strokedb'
    g.install_message = " - Thanks for installing merb_strokedb!\n" +
                        " - Add this to your config/init.rb to get started:\n"+
                        " -   use_orm :strokedb"
  end
  
  desc 'tests packaged files to ensure they are all present'
  task :verify => :package do
    # An error message will be displayed if files are missing
    if system %(ruby -e "require 'rubygems'; require 'merb-core'; require 'pkg/merb_strokedb-#{Merb::Orms::StrokeDB::VERSION}/lib/merb_strokedb'")
      puts "\nThe library files are present"
    end
  end
  
  task :copy_gemspec => [:package] do
    pkg = Dir['pkg/*'].select {|dir| File.directory? dir}.last
    mv File.join(pkg, pkg.gsub(/^pkg\//,'').gsub(/\-\d+$/,'.gemspec')), './'
  end
  
  desc 'builds a gemspec as GitHub wants it'
  task :gemspec => [:package, :copy_gemspec, :clobber_package]
  
  # desc 'Run specs, clean tree, update manifest, run coverage, and install gem!'
  desc 'Clean tree, update manifest, and install gem!'
  task :magic => [:clean, :manifest, :install]
end