require "rubygems"
require "irdb"

module ActiveRecord
  class Base
    # Establishes a connection to the database that's used by all Active Record objects
    def self.irdb_connection(config) # :nodoc:
      provider_name = config[:provider]
      cstr          = config[:connection_string]
      factory       = IRDb::DbProviderFactory.new
      provider      = factory.create_provider provider_name
      db            = IRDb::Database.new(provider, cstr)
      ConnectionAdapters::IRDbAdapter.new(db, logger)
    end
  end
  
  module ConnectionAdapters
    class IRDbAdapter < AbstractAdapter
      def initialize(connection, logger)
        super
      end
    end
  end
end
