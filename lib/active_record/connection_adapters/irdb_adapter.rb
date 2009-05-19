require "rubygems"
require "irdb"

module ActiveRecord
  class Base
    # Establishes a connection to the database that's used by all Active Record objects
    def self.irdb_connection(config) # :nodoc:
      # TODO: verify provider and connection string
      provider_name = config[:provider]
      cstr          = config[:cstr]
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
      
      def select(sql, name=nil)
        begin
          @connection.execute_hash sql
        rescue System::Data::Common::DbException
          raise ActiveRecord::StatementInvalid, "#{$!}"
        end
      end
      
      def add_limit_offset!(sql, options)
        if options[:limit]
          "SET ROWCOUNT #{options[:limit]}; #{sql}"
        end
      end
      
      def columns(table_name, name=nil)
        cols = @connection.columns(table_name)
        p cols
        cols.map do |col|
          Column.new(col[:name], col[:type], col[:default], col[:nullable?])
        end
      end
    end
  end
end
