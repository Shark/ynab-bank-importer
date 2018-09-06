require 'rubygems'

require 'bundler/setup'
require 'yaml'
require 'ynab'
require 'raven'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |f| require f }
Dir[File.join('.', 'lib/**/*.rb')].each { |f| require f }

task :import do
  Importer.run
end