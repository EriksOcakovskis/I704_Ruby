require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

task default: :test

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |_t, args|
    require 'sequel'
    Sequel.extension :migration
    db = Sequel.connect(ENV.fetch('DATABASE_URL'))
    if args[:version]
      puts 'Migrating to version #{args[:version]}'
      Sequel::Migrator.run(db, 'db/migrations', target: args[:version].to_i)
    else
      puts 'Migrating to latest'
      Sequel::Migrator.run(db, 'db/migrations')
    end
  end

  desc 'Check migrations'
  task :check_migrations do |_t|
    require 'sequel'
    Sequel.extension :migration
    db = Sequel.connect(ENV.fetch('DATABASE_URL'))
    puts 'Checking if migrations are up to date'
    Sequel::Migrator.check_current(db, 'db/migrations')
  end
end
