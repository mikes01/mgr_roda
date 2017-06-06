require_relative 'db'

if ENV['RACK_ENV'] == 'development'
  Sequel::Model.cache_associations = false
end

Sequel::Model.plugin :auto_validations
Sequel::Model.plugin :prepared_statements
Sequel::Model.plugin :subclasses unless ENV['RACK_ENV'] == 'development'
Sequel::Model.plugin :forme
Sequel::Model.plugin :timestamps, update_on_create: true

unless defined?(Unreloader)
  require 'rack/unreloader'
  Unreloader = Rack::Unreloader.new(:reload=>false)
end

Unreloader.require('models'){|f| Sequel::Model.send(:camelize, File.basename(f).sub(/\.rb\z/, ''))}
Point.set_dataset Point.dataset.select_append{st_astext(:coordinates).as(:coordinates_text)}
Line.set_dataset Line.dataset.select_append{st_astext(:coordinates).as(:coordinates_text)}

if ENV['RACK_ENV'] == 'development'
  require 'logger'
  DB.loggers << Logger.new($stdout)
else
  Sequel::Model.freeze_descendents
  DB.freeze
end
