# Move this to application.rb if you want it to be reloadable in dev mode.
Merb::Router.prepare do |r|
  r.match('/').to(:controller => 's_d_b_test', :action =>'index')
  r.default_routes
end


Merb::Config.use { |c|
  c[:environment]         = 'production',
  c[:framework]           = {},
  c[:log_level]           = 'debug',
  c[:use_mutex]           = false,
  c[:session_store]       = 'cookie',
  c[:session_id_key]      = '_session_id',
  c[:session_secret_key]  = 'c1d41384ec11f78e2bf0a44cedf3976fa112b5f5',
  c[:exception_details]   = true,
  c[:reload_classes]      = true,
  c[:reload_time]         = 0.5
}

# Development StrokeDB
STROKEDB_PATH = '/Users/elliottcable/Documents/Work/Code/strokedb/strokedb-ruby/strokedb.rb'
# STROKEDB_PATH = nil

raise 'You need to set STROKEDB_PATH in config/init.rb!' unless STROKEDB_PATH

require STROKEDB_PATH
use_orm :strokedb

dependency 'merb-haml', '> 0.9'