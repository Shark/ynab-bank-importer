require 'rubygems'

require 'bundler/setup'
require 'yaml'
require 'ynab'
require 'raven'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |f| require f }
Dir[File.join('.', 'lib/**/*.rb')].each { |f| require f }

module Clockwork
  error_handler do |error|
    Raven.capture_exception(error)
  end

  every(8 * 60 * 60, 'import_transactions') do # 8 hours
    # Gathering transactions
    transactions =
    Settings.all['accounts'].map do |a|
      account = Account.new(a)
      account.fetch_transactions
      account.transactions
    end.flatten!

    # Importing transactions
    budget_id = Settings.all['ynab'].fetch('budget_id')
    access_token = Settings.all['ynab'].fetch('access_token')

    ynab_api = YNAB::API.new(access_token)
    bulk_transactions = YNAB::BulkTransactions.new(transactions: transactions)
    ynab_api.transactions.bulk_create_transactions(budget_id, bulk_transactions)
  end
end