# frozen_string_literal: true

describe MoneyBankTwelvedataApi::Data do
  context "class methods" do
    it ".cache_dir returns the full path of the cached data folder" do
      expect(described_class.cache_dir).to_not be_nil
    end

    it ".cache_dir= can set a different full path of the cache folder" do
      old_cache_dir = described_class.cache_dir
      new_cache_dir = "/tmp/cache_dir"
      expect { described_class.cache_dir = new_cache_dir }
        .to change(described_class, :cache_dir).from(old_cache_dir).to(new_cache_dir)
    end
  end
end
