# frozen_string_literal: true

describe MoneyBankTwelvedataApi do
  it "has a version number which is equal to 0.1.0" do
    expect(described_class::VERSION).to eq("0.1.0")
  end

  it "has an `Error` class defined" do
    expect(described_class.const_defined?("Error")).to eq(true)
  end

  it ".client returns a singleton instance of TwelvedataRuby::Client" do
    expect(described_class.client).to eql(TwelvedataRuby::Client.instance)
  end
end
