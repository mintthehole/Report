pre_process do
  migrations_folder = File.expand_path(File.dirname(__FILE__) + '/migrations')
  version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil
  ActiveRecord::Base.establish_connection(:production)
  ActiveRecord::Migrator.migrate(migrations_folder, 20150205080480)
end