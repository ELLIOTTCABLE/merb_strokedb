require 'fileutils'
require 'strokedb' unless Object.const_defined? 'StrokeDB'

module Merb
  module Orms
    
    module StrokeDB
      THREADS = []
      VERSION = '0'
      
      class << self
        def config_file() Merb.root / "config" / "store.yml" end
        def sample_dest() Merb.root / "config" / "store.example.yml" end
        def sample_source() File.dirname(__FILE__) / "store.example.yml" end
      
        def copy_sample_config
          FileUtils.cp sample_source, sample_dest unless File.exists?(sample_dest)
        end
      
        def config
          @config ||=
            begin
              # Convert string keys to symbols
              full_config = Erubis.load_yaml_file(config_file)
              config = (Merb::Plugins.config[:merb_strokedb] = {})
              
              envd_config = (full_config[Merb.environment.to_sym] || full_config[Merb.environment])
              envd_config.each do |k, v| 
                if k == 'port'
                  config[k.to_sym] = v.to_i
                else
                  config[k.to_sym] = v
                end
              end
              config
            end
        end
      
        # Database connects as soon as the gem is loaded
        def connect
          if File.exists?(config_file)
            Merb.logger.info!("Setting up & connecting to database db/#{config[:database]}.strokedb...")
            ::StrokeDB.use_global_default_config!
            
            if config[:threadsafe]
              Merb.logger.info!("Starting StrokeDB DRb server on druby://localhost:#{config[:port]}...")
              # Create the server, and detach...
              ::StrokeDB::Config.build :default => true, :base_path => "db/#{config[:database]}.strokedb"
              Merb::Orms::StrokeDB::THREADS <<
                ::StrokeDB.default_store.remote_server("druby://localhost:#{config[:port]}").start
            
              Merb::Orms::StrokeDB::THREADS.map do |thread|
                ::Kernel.fork { thread.join }
              end
            
            
              # Reattach to the now-running server
              ::StrokeDB.default_store = ::StrokeDB::RemoteStore::DRb::Client.new("druby://localhost:#{config[:port]}")
            else
              ::StrokeDB::Config.build :default => true, :base_path => "db/#{config[:database]}.strokedb"
            end
          else
            copy_sample_config
            Merb.logger.warn "No store.yml file found in #{Merb.root}/config."
            Merb.logger.warn "A sample file was created called store.example.yml for you to copy and edit."
            exit(1)
          end
        end
        
        # Registering this ORM lets the user choose StrokeDB as a session store
        # in merb.yml's session_store: option. No idea if this works, correctly...?
        def register_session_type
          Merb.register_session_type("strokedb",
          "merb/session/strokedb_session",
          "Using StrokeDB sessions")
        end
      end
    end
    
  end
end