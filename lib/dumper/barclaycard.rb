class Dumper
  # Implements logic to fetch transactions via the Barclaycard website
  # and implements methods that convert the response to meaningful data.
  class Barclaycard < Dumper
    require 'barclayscraper'
    require 'digest/md5'

    def initialize(params = {})
      @ynab_id    = params.fetch('ynab_id')
      @username   = params.fetch('username')
      @password   = params.fetch('password')
      @product_id = params.fetch('product_id')
    end

    def fetch_transactions
      account = Barclayscraper::Account.new(
        username: @username,
        password: @password,
        product_id: @product_id
      )

      account.transactions.map { |t| to_ynab_transaction(t) }
    end

    private

    def account_id
      @ynab_id
    end

    def date(transaction)
      transaction.fetch(:date)
    end

    def payee_name(_transaction)
      'N/A'
    end

    def payee_iban(_transaction)
      nil
    end

    def memo(transaction)
      transaction.fetch(:memo)
    end

    def amount(transaction)
      (transaction.fetch(:amount).to_f * 1000).to_i
    end

    def withdrawal?(transaction)
      false # TODO: implement
    end

    def import_id(transaction)
      data = [@product_id,
              date(transaction),
              memo(transaction),
              amount(transaction)
             ].join

      Digest::MD5.hexdigest(data)
    end
  end
end
