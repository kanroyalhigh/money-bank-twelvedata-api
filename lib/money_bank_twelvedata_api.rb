# frozen_string_literal: true

require 'twelvedata_ruby'

require_relative "money_bank_twelvedata_api/version"
require_relative "money_bank_twelvedata_api/data"
require_relative "money_bank_twelvedata_api/currency"
require_relative "money_bank_twelvedata_api/forex"
require_relative "money_bank_twelvedata_api/crypto"

module MoneyBankTwelvedataApi
  class Error < StandardError; end
end
