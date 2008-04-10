if defined?(Merb::Plugins)
  require File.join(File.dirname(__FILE__) / :merb / :orms / :strokedb / :connection)
  Merb::Plugins.add_rakefiles 'merb_strokedb' / 'strokedb.task'
  
  class Merb::Orms::StrokeDB::Connect < Merb::BootLoader

    after BeforeAppRuns

    def self.run
      Merb::Orms::StrokeDB.connect
      # Merb::Orms::DataMapper.register_session_type
    end

  end
end