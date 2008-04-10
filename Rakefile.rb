require 'rubygems'
require 'hoe'
require 'merb-core'

$:.unshift(File.dirname(__FILE__) + "/lib")
require 'merb_strokedb'

Hoe.new('merb_strokedb', Merb::Orms::StrokeDB::VERSION) do |g|
  g.name = 'merb_strokedb'
  g.url = 'http://find.elliottcable.name/merb_strokedb'
  g.developer('elliottcable', 'merb_strokedb@elliottcable.com')
  
  g.summary = 'StrokeDB plugin for Merb.'
  g.description = 'merb_strokedb is a plugin for Merb, that allows the' +
                 ' setting of strokedb as the default ORM.'
  
  g.extra_deps = ['merb-core', 'strokedb']
  
  g.rubyforge_name = 'merb-strokedb'
  g.remote_rdoc_dir = ''
  g.intuit = false # You need elliottcable's hacked hoe:
  # http://github.com/elliottcable/hoe/commits/master
end

windows = (PLATFORM =~ /win32|cygwin/) rescue nil

SUDO = windows ? "" : "sudo"

desc "tests packaged files to ensure they are all present"
task :verify => :package do
  # An error message will be displayed if files are missing
  if system %(ruby -e "require 'rubygems'; require 'merb-core'; require 'pkg/merb_strokedb-#{Merb::Orms::StrokeDB::VERSION}/lib/merb_strokedb'")
    puts "\nThe library files are present"
  end
end

desc "Install merb_strokedb"
task :install => :package do
  sh %{#{SUDO} gem install pkg/merb_strokedb-#{Merb::Orms::StrokeDB::VERSION} --no-rdoc --no-ri --no-update-sources}
end

task :manifest => :clean do
  sh %{rake check_manifest | patch} rescue nil
end

# desc "Clears the manifest, because of Hoe's shit about .git folders. Fuck hoe."
task :clobber_manifest do
  sh %{rm -f Manifest.txt; touch Manifest.txt} rescue nil
end

# desc "Run specs, clean tree, update manifest, run coverage, and install gem!"
desc "Clean tree, update manifest, and install gem!"
task :magic => [:clean, :manifest, :install, :clobber_manifest]