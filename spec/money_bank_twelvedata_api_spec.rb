# frozen_string_literal: true

RSpec.describe MoneyBankTwelvedataApi do
  it "has a version number which is equal to 0.1.0" do
    expect(MoneyBankTwelvedataApi::VERSION).to eq("0.1.0")
  end

  it "has an `Error` class defined" do
    expect(MoneyBankTwelvedataApi.const_defined?("Error")).to eq(true)
  end
end
