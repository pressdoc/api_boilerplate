require 'rubygems'
require 'bundler/setup'

require 'rake'
require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :environment do
  ENV['RACK_ENV'] ||= 'development'
  require File.expand_path('../config/environment', __FILE__)
end

task routes: :environment do
  App::API.routes.each do |route|
    method = route.route_method.ljust(10)
    path = route.route_path
    puts "     #{method} #{path}"
  end
end

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    unless ENV['RACK_ENV'] == "production"
      require 'dotenv'
      Dotenv.load
      Dotenv.overload ".env.#{ENV['RACK_ENV']}"
    end

    require "sequel"
    Sequel.extension :migration

    db = Sequel.connect(ENV["PG_URI"])
    db.extension :pg_json
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "db/migrations")
    end
  end
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

task default: [:rubocop, :spec]