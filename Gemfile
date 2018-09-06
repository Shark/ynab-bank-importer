ruby IO.read('.ruby-version').strip
source 'https://rubygems.org'

gem 'httparty'
gem 'ynab', '~> 1.2.0'

# Dumper: BBVA
gem 'bankscrap'
gem 'bankscrap-bbva', '~> 2.0.2'

# Dumper: N26
gem 'twentysix'

# Dumper: FinTS
gem 'ruby_fints', '0.0.3'

# Dumper: Barclaycard
gem 'barclayscraper', git: 'https://github.com/Shark/barclayscraper.git'

gem 'clockwork'
gem 'sentry-raven'
gem 'rake'

gem 'base32'

group :development do
  gem 'rubocop', '~> 0.52.1', require: false
  gem 'rubocop-rspec'
end

group :test do
  gem 'rspec'
  gem 'vcr'
  gem 'webmock'
end
