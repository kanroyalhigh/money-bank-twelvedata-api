# frozen_string_literal: true

module MoneyBankTwelvedataApi
  class Data
    @@cache_dir = File.join(File.dirname(__FILE__), "..", "..", "cache")
    @@apikey = nil

    class << self
      def cache_dir
        @@cache_dir
      end

      def cache_dir=(cache_dir)
        return unless cache_dir

        @@cache_dir_exists = nil
        @@cache_dir = cache_dir
      end

      def cache_dir_exists?
        @@cache_dir_exists ||= Dir.exists?(cache_dir)
      end

      def api_client(another_api_key=nil)
        TwelvedataRuby.client(apikey: another_api_key || apikey)
      end

      def apikey=(apikey)
        @@apikey = apikey
      end

      def apikey
        @@apikey
      end

      def fetch(ccy_type=nil)
        return nil unless Currency.types.include?(ccy_type) && MoneyBankTwelvedataApi.const_defined?(ccy_type)

        resp = api_client.send(MoneyBankTwelvedataApi.const_get(ccy_type).endpoint)
      end
    end
  end
end
