# frozen_string_literal: true

module MoneyBankTwelvedataApi
  class Currency
    TYPES = {"Forex" => "forex_pairs", "Crypto" => "cryptocurrencies"}.freeze
    CCY_PAIR_KEYS = %i[currency_base currency_quote].freeze
    # rubocop:disable Style/ClassVars
    @@mem_cache = {}
    @@mutex = Mutex.new
    # rubocop:enable Style/ClassVars
    class << self
      def cache_file_full_path
        return nil unless cache_key

        File.join(Data.cache_dir, "#{cache_key}.json")
      end

      def types
        @@types ||= TYPES.keys
      end

      def endpoint
        TYPES[ccy_type_name]
      end

      def ccy_type_name
        ccy_name = "#{name.split("::").last}"
        types.include?(ccy_name) ? ccy_name : nil
      end

      def mem_cache!(json_data)
        return nil unless cache_key

        @@mem_cache.merge!(cache_key => json_data)
      end

      def mem_cache
        return update_file_cache! if force_update_file_cache?
        return load_cache_file! if force_cache_reload?

        ccy_mem_cache
      end

      def cache_key
        return nil unless ccy_type_name

        ccy_type_name.downcase.to_sym
      end

      def api_data_fetch(ccy_type=nil)
        data = Data.fetch(ccy_type || ccy_type_name)
        return nil if data.error

        data.body[:data].inject({}) do |hsh, d|
          d[:symbol].split("/").each_with_index do |ccy_sym, idx|
            hsh.merge!(ccy_sym => d[CCY_PAIR_KEYS[idx]]) unless hsh[ccy_sym]
          end
          hsh
        end
      end

      def update_file_cache!
        FileUtils.mkdir_p(Data.cache_dir) unless Data.cache_dir_exists?
        json = api_data_fetch
        File.open(cache_file_full_path, "wb:ASCII-8BIT") do |f|
          f.flock(File::LOCK_EX)
          f.chmod(0644)
          f.write(JSON.dump(json))
          mem_cache!(json)
        end
      end

      private

      def force_cache_reload?
        !ccy_mem_cache&.any?
      end

      def force_update_file_cache?
        [Crypto, Forex].each {|klass| klass.mem_cache } unless cache_key

        !cache_file_full_path.nil? && File.size?(cache_file_full_path).nil?
      end

      def load_cache_file!
        mem_cache!(JSON.parse(File.binread(cache_file_full_path)))
      end

      def ccy_mem_cache
        cache_key ? @@mem_cache[cache_key] : @@mem_cache
      end
    end
  end
end
