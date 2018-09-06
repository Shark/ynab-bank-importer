class Importer
  def self.run
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