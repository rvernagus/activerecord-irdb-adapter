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
      # TODO: detect provider name here and include provider-specific module
      ConnectionAdapters::SqlClientAdapter.new(db, logger)
    end
  end
  
  module ConnectionAdapters
    class IRDbAdapter < AbstractAdapter
      def native_database_types
        {
          :primary_key => "int not null identity(1,1) primary key",
          :string      => { :name => "varchar", :limit => 255 },
          :float       => { :name => "float" }
        }
      end
      
      def select(sql, name=nil)
        log sql, name
        begin
          @connection.execute_hash sql
        rescue System::Data::Common::DbException
          raise ActiveRecord::StatementInvalid, "#{$!}"
        end
      end
      
      def add_limit_offset!(sql, options)
        log sql, nil
        if options[:limit]
          "SET ROWCOUNT #{options[:limit]}; #{sql}"
        end
      end
      
      def columns(table_name, name=nil)
        log "Get columns for #{table_name}...", nil
        cols = @connection.columns(table_name)
        cols.map do |col|
          Column.new(col[:name], col[:type], col[:default], col[:nullable?])
        end
      end
      
      def execute(sql, name=nil)
        log sql, nil
        @connection.execute_non_query sql
      end
    end
    
    class SqlClientAdapter < IRDbAdapter
      def select(sql, name=nil)
        results = super
        # TODO: Create result mapping actions that can be used by different providers?
        results.map do |result|
          result.each do |k, v|
            result[k] = v.to_s.rstrip if v.class == System::String
            result[k] = nil if v.class == System::DBNull
          end
          result
        end
      end
    end
  end
end
